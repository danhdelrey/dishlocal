// File: supabase/functions/sync-post-to-algolia/index.ts

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

// =======================================================================
// === THAY ĐỔI 1: CẬP NHẬT KIỂU DỮ LIỆU `Post` ============================
// =======================================================================
// Thêm các trường mới mà trigger của Supabase sẽ gửi đến.
// Đảm bảo tên trường khớp với tên cột trong bảng 'posts' của bạn.
type Post = {
  id: string;
  image_url: string;
  dish_name: string;
  location_name: string;
  location_address: string;
  price: number;
  insight: string;
  latitude?: number;
  longitude?: number;

  // CÁC TRƯỜNG MỚI CHO FILTERING VÀ SORTING
  like_count: number;
  save_count: number;
  comment_count: number;
  food_category: string | null;
  created_at: string; // Trigger gửi dưới dạng chuỗi ISO
};


// =======================================================================
// === THAY ĐỔI 2: CẬP NHẬT HÀM `toAlgoliaObject` =========================
// =======================================================================
// Chuyển đổi object Post nhận từ trigger thành object Algolia hoàn chỉnh.
function toAlgoliaObject(post: Post) {
  const geoData = (post.latitude !== undefined && post.longitude !== undefined)
    ? { _geoloc: { lat: post.latitude, lng: post.longitude } }
    : {};

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

    // --- THÊM CÁC TRƯỜG MỚI VÀO ĐÂY ---
    like_count: post.like_count,
    save_count: post.save_count,
    comment_count: post.comment_count,
    food_category: post.food_category,
    
    // Chuyển đổi `created_at` thành Unix timestamp (số) để sắp xếp
    created_at: Math.floor(new Date(post.created_at).getTime() / 1000),

    // Các trường này có thể giữ lại nếu cần
    latitude: post.latitude,
    longitude: post.longitude,
  };
}

// Hàm xử lý chính của Edge Function (phần còn lại không cần thay đổi)
serve(async (req) => {
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method Not Allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    });
  }

  try {
    // Lấy biến môi trường Algolia
    const algoliaAppId = Deno.env.get("ALGOLIA_APP_ID");
    const algoliaAdminApiKey = Deno.env.get("ALGOLIA_ADMIN_KEY");
    const algoliaIndexName = "posts";

    if (!algoliaAppId || !algoliaAdminApiKey || !algoliaIndexName) {
      throw new Error("Algolia environment variables are not set.");
    }

    // Lấy payload từ Supabase trigger
    const { type, record, old_record } = await req.json();

    let algoliaAction: "addObject" | "updateObject" | "deleteObject";
    let algoliaBody: any = {};

    if (type === "INSERT") {
      algoliaAction = "addObject";
      // Hàm toAlgoliaObject đã được cập nhật
      algoliaBody = toAlgoliaObject(record); 
    } else if (type === "UPDATE") {
      algoliaAction = "updateObject";
      // Hàm toAlgoliaObject đã được cập nhật
      algoliaBody = toAlgoliaObject(record); 
    } else if (type === "DELETE") {
      algoliaAction = "deleteObject";
      algoliaBody = { objectID: old_record.id };
    } else {
      return new Response(JSON.stringify({ error: "Unknown trigger type" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Gửi request tới Algolia
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
          requests: [
            {
              action: algoliaAction,
              body: algoliaBody,
            },
          ],
        }),
      }
    );

    if (!algoliaResponse.ok) {
      const errorBody = await algoliaResponse.json();
      console.error("Algolia API Error:", errorBody);
      throw new Error(`Algolia sync failed. Status: ${algoliaResponse.status}`);
    }

    return new Response(
      JSON.stringify({ message: `Algolia sync ${algoliaAction} successful.` }),
      { status: 200, headers: { "Content-Type": "application/json" } }
    );
  } catch (error) {
    console.error(error);
    return new Response(
      JSON.stringify({ error: (error instanceof Error) ? error.message : "Unknown error" }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});