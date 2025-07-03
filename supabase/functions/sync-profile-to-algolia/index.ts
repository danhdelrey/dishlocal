import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

// Định nghĩa kiểu dữ liệu cho profile
type Profile = {
  id: string;
  username: string;
  display_name: string;
  photo_url: string;
  bio: string;
  follower_count: number;
  following_count: number;
};

// Chuyển đổi profile thành object cho Algolia
function toAlgoliaObject(profile: Profile) {
  return {
    objectID: profile.id,
    ...profile,
  };
}

// Hàm xử lý chính của Edge Function
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
    const algoliaIndexName = "profiles";

    if (!algoliaAppId || !algoliaAdminApiKey || !algoliaIndexName) {
      throw new Error("Algolia environment variables are not set.");
    }

    // Lấy payload từ Supabase trigger
    const { type, record, old_record } = await req.json();

    let algoliaAction: "addObject" | "updateObject" | "deleteObject";
    let algoliaBody: any = {};

    if (type === "INSERT") {
      algoliaAction = "addObject";
      algoliaBody = toAlgoliaObject(record);
    } else if (type === "UPDATE") {
      algoliaAction = "updateObject";
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