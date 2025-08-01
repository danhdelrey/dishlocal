// File: supabase/functions/sync-all-posts-to-algolia/index.ts

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Hàm xử lý chính của Edge Function
serve(async (req) => {
  // Chỉ cho phép phương thức POST để tránh bị gọi nhầm
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method Not Allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    });
  }

  try {
    // 1. Lấy các biến môi trường đã thiết lập (không đổi)
    const algoliaAppId = Deno.env.get("ALGOLIA_APP_ID");
    const algoliaAdminApiKey = Deno.env.get("ALGOLIA_ADMIN_KEY");
    const algoliaIndexName = "posts";

    if (!algoliaAppId || !algoliaAdminApiKey || !algoliaIndexName) {
      throw new Error("Algolia environment variables are not set.");
    }

    // 2. Tạo Supabase client để truy vấn dữ liệu (không đổi)
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: req.headers.get("Authorization")! } } }
    );

    // 3. LẤY THÊM DỮ LIỆU TỪ BẢNG 'posts'
    // =======================================================================
    // === THAY ĐỔI QUAN TRỌNG NHẤT ==========================================
    // =======================================================================
    // Thêm các trường cần thiết cho việc lọc và sắp xếp vào câu lệnh `select`.
    const { data: posts, error: supabaseError } = await supabaseClient
      .from("posts")
      .select(`
        id, 
        image_url, 
        dish_name, 
        location_name, 
        location_address, 
        latitude, 
        longitude, 
        price, 
        insight,
        like_count,
        save_count,
        comment_count,
        food_category,
        created_at
      `);

    if (supabaseError) throw supabaseError;
    if (!posts || posts.length === 0) {
      return new Response(JSON.stringify({ message: "No posts to sync." }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    // 4. CHUẨN BỊ DỮ LIỆU ĐỂ GỬI LÊN ALGOLIA (với các trường mới)
    const algoliaObjects = posts.map(post => {
      const geoData = (post.latitude && post.longitude) 
        ? { _geoloc: { lat: post.latitude, lng: post.longitude } }
        : {};

      // THÊM CÁC TRƯỜNG MỚI VÀO OBJECT GỬI ĐI
      return {
        objectID: post.id,
        id: post.id,
        image_url: post.image_url,
        dish_name: post.dish_name,
        location_name: post.location_name,
        location_address: post.location_address,
        price: post.price,
        insight: post.insight,
        ...geoData,
        
        // --- CÁC TRƯỜNG MỚI CHO FILTERING VÀ SORTING ---
        like_count: post.like_count,
        save_count: post.save_count,
        comment_count: post.comment_count,
        food_category: post.food_category,

        // Algolia xử lý chuỗi ISO 8601 của timestamp rất tốt.
        // Để có thể sắp xếp theo ngày, chúng ta cần gửi lên một giá trị số.
        // Unix timestamp (giây) là một lựa chọn tuyệt vời.
        created_at: Math.floor(new Date(post.created_at).getTime() / 1000),

        // Chúng ta vẫn có thể giữ lại latitude và longitude riêng nếu cần
        latitude: post.latitude,
        longitude: post.longitude,
      };
    });

    // 5. Gửi dữ liệu lên Algolia bằng REST API (sử dụng fetch)
    const batchSize = 1000;
    let totalSynced = 0;

    for (let i = 0; i < algoliaObjects.length; i += batchSize) {
      const batch = algoliaObjects.slice(i, i + batchSize);

      const algoliaResponse = await fetch(
        `https://${algoliaAppId}-dsn.algolia.net/1/indexes/${algoliaIndexName}/batch`,
        {
          method: "POST",
          headers: {
            "X-Algolia-Application-Id": algoliaAppId,
            "X-Algolia-API-Key": algoliaAdminApiKey,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            requests: batch.map(obj => ({
              action: "updateObject",
              body: obj,
            })),
          }),
        }
      );

      if (!algoliaResponse.ok) {
        const errorBody = await algoliaResponse.json();
        console.error("Algolia API Error:", errorBody);
        throw new Error(`Failed to sync batch starting at index ${i}. Status: ${algoliaResponse.status}`);
      }
      
      totalSynced += batch.length;
      console.log(`Synced batch of ${batch.length} objects to Algolia.`);
    }

    // 6. Trả về kết quả thành công
    return new Response(
      JSON.stringify({
        message: `Successfully synced ${totalSynced} posts to Algolia index '${algoliaIndexName}'.`,
      }),
      {
        status: 200,
        headers: { "Content-Type": "application/json" },
      }
    );

  } catch (error) {
    console.error(error);
    return new Response(JSON.stringify({ error: (error instanceof Error) ? error.message : "An unknown error occurred" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});