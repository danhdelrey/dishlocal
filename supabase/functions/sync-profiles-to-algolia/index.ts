import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

// --- Các hàm helper để chuyển đổi snake_case sang camelCase (giữ nguyên) ---
function snakeToCamel(s: string): string {
  return s.replace(/([-_][a-z])/ig, ($1) => {
    return $1.toUpperCase().replace('-', '').replace('_', '');
  });
}

function keysToCamel(obj: any): any {
  if (typeof obj !== 'object' || obj === null) {
    return obj;
  }
  if (Array.isArray(obj)) {
    return obj.map(v => keysToCamel(v));
  }
  return Object.keys(obj).reduce((acc: {[key: string]: any}, key: string) => {
    acc[snakeToCamel(key)] = keysToCamel(obj[key]);
    return acc;
  }, {});
}

console.log("Function sync-profiles-to-algolia started.");

serve(async (req) => {
  // Xử lý CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
    } })
  }

  try {
    // 1. Lấy các biến môi trường
    const ALGOLIA_APP_ID = Deno.env.get('ALGOLIA_APP_ID')!;
    const ALGOLIA_ADMIN_KEY = Deno.env.get('ALGOLIA_ADMIN_KEY')!;
    const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
    const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

    if (!ALGOLIA_APP_ID || !ALGOLIA_ADMIN_KEY || !SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
        throw new Error("Missing required environment variables/secrets.");
    }
    
    const supabaseClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // 2. THAY ĐỔI: Lấy dữ liệu từ bảng `profiles`
    let allProfiles = [];
    let page = 0;
    const pageSize = 1000; 

    while (true) {
        const { data: profiles, error } = await supabaseClient
            .from('profiles') // <-- Bảng 'profiles'
            .select(`
                id,
                username,
                display_name,
                photo_url,
                bio,
                follower_count,
                following_count,
                is_setup_completed
            `) // <-- Các trường của bảng 'profiles'
            .range(page * pageSize, (page + 1) * pageSize - 1);

        if (error) throw error;
        if (profiles.length === 0) break;
        
        allProfiles.push(...profiles);
        page++;
    }

    console.log(`Fetched a total of ${allProfiles.length} profiles from Supabase.`);

    if (allProfiles.length === 0) {
        return new Response(JSON.stringify({ message: "No profiles to sync." }), {
            headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
            status: 200,
        });
    }

    // 3. THAY ĐỔI: Chuyển đổi dữ liệu profile cho Algolia
    const recordsForAlgolia = allProfiles.map(profile => {
      const camelCaseProfile = keysToCamel(profile);
      return {
        objectID: camelCaseProfile.id, // Vẫn dùng 'id' làm objectID
        ...camelCaseProfile
        // Không có trường _geoloc ở đây
      };
    });

    // 4. THAY ĐỔI: Gửi dữ liệu lên index 'profiles' của Algolia
    console.log(`Sending ${recordsForAlgolia.length} records to Algolia...`);
    const indexName = 'profiles'; // <-- Tên index mới
    const algoliaUrl = `https://${ALGOLIA_APP_ID}.algolia.net/1/indexes/${indexName}/batch`;

    const algoliaRequestBody = {
        requests: recordsForAlgolia.map(record => ({
            action: 'updateObject',
            body: record
        }))
    };

    const response = await fetch(algoliaUrl, {
        method: 'POST',
        headers: {
            'X-Algolia-Application-Id': ALGOLIA_APP_ID,
            'X-Algolia-API-Key': ALGOLIA_ADMIN_KEY,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(algoliaRequestBody)
    });

    if (!response.ok) {
        const errorBody = await response.json();
        throw new Error(`Algolia API error: ${response.statusText} - ${JSON.stringify(errorBody)}`);
    }

    const result = await response.json();
    console.log(`Successfully processed batch request to Algolia. Task ID: ${result.taskID}`);
    
    return new Response(
      JSON.stringify({
        message: `Successfully sent ${recordsForAlgolia.length} profiles for indexing to Algolia.`,
      }),
      {
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
        status: 200,
      }
    );

  } catch (error) {
    console.error("An error occurred:", error);
    const errorMessage = error instanceof Error ? error.message : "An unknown error occurred.";
    return new Response(
      JSON.stringify({ error: errorMessage }),
      {
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
        status: 500,
      }
    )
  }
})