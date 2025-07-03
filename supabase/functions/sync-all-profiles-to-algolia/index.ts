import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Hàm xử lý chính của Edge Function
serve(async (req) => {
  // Chỉ cho phép phương thức POST
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method Not Allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    });
  }

  try {
    // 1. Lấy các biến môi trường
    const algoliaAppId = Deno.env.get("ALGOLIA_APP_ID");
    const algoliaAdminApiKey = Deno.env.get("ALGOLIA_ADMIN_KEY");
    // Lấy tên index dành riêng cho profiles
    const algoliaIndexName = "profiles";

    if (!algoliaAppId || !algoliaAdminApiKey || !algoliaIndexName) {
      throw new Error("Algolia environment variables for profiles are not set.");
    }

    // 2. Tạo Supabase client
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: req.headers.get("Authorization")! } } }
    );

    // 3. Lấy tất cả dữ liệu từ bảng 'profiles' với các trường cần thiết
    const { data: profiles, error: supabaseError } = await supabaseClient
      .from("profiles")
      .select(`
        id,
        username,
        display_name,
        photo_url,
        bio,
        follower_count,
        following_count
      `);

    if (supabaseError) throw supabaseError;
    if (!profiles || profiles.length === 0) {
      return new Response(JSON.stringify({ message: "No profiles to sync." }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    // 4. Chuẩn bị dữ liệu để gửi lên Algolia
    const algoliaObjects = profiles.map(profile => ({
      // Map 'id' thành 'objectID' cho Algolia
      objectID: profile.id,
      ...profile
    }));

    // 5. Gửi dữ liệu lên Algolia bằng REST API theo từng batch
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
              action: "updateObject", // Tạo mới hoặc cập nhật
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
        message: `Successfully synced ${totalSynced} profiles to Algolia index '${algoliaIndexName}'.`,
      }),
      {
        status: 200,
        headers: { "Content-Type": "application/json" },
      }
    );

  } catch (error) {
    console.error(error);
    return new Response(JSON.stringify({ error: error instanceof Error ? error.message : "An unknown error occurred" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});