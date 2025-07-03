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
    // 1. Lấy các biến môi trường đã thiết lập
    const algoliaAppId = Deno.env.get("ALGOLIA_APP_ID");
    const algoliaAdminApiKey = Deno.env.get("ALGOLIA_ADMIN_KEY");
    const algoliaIndexName = "posts";

    if (!algoliaAppId || !algoliaAdminApiKey || !algoliaIndexName) {
      throw new Error("Algolia environment variables are not set.");
    }

    // 2. Tạo Supabase client để truy vấn dữ liệu
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: req.headers.get("Authorization")! } } }
    );

    // 3. Lấy tất cả dữ liệu từ bảng 'posts' với các trường cần thiết
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
        insight
      `);

    if (supabaseError) throw supabaseError;
    if (!posts || posts.length === 0) {
      return new Response(JSON.stringify({ message: "No posts to sync." }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    // 4. Chuẩn bị dữ liệu để gửi lên Algolia
    // Algolia sử dụng `objectID` làm định danh duy nhất.
    // Chúng ta sẽ map `id` của Supabase thành `objectID`.
    const algoliaObjects = posts.map(post => ({
      ...post,
      objectID: post.id,
    }));

    // 5. Gửi dữ liệu lên Algolia bằng REST API (sử dụng fetch)
    // Chia nhỏ dữ liệu thành các batch (ví dụ mỗi batch 1000 object) để không bị quá tải
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
              action: "updateObject", // 'updateObject' sẽ tạo mới nếu chưa có, hoặc cập nhật nếu đã có
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
    return new Response(JSON.stringify({ error: (error as Error).message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});