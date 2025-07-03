import { serve } from "https://deno.land/std@0.168.0/http/server.ts";


// Define a type for the post object
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
};

// Tạo object Algolia từ record
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
    latitude: post.latitude,
    longitude: post.longitude,
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