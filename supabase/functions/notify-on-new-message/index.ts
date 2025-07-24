import { serve } from "std/http/server.ts";
import { createClient } from "supabase-js";
// THAY ĐỔI: Sử dụng thư viện djwt đã được xác minh
import { create, getNumericDate, type Header } from "djwt";

// Helper function để import private key
async function importKey(pem: string) {
  const pemHeader = "-----BEGIN PRIVATE KEY-----";
  const pemFooter = "-----END PRIVATE KEY-----";
  
  // === THAY ĐỔI QUAN TRỌNG ===
  // 1. Thay thế các chuỗi "\\n" thành "" để loại bỏ các ký tự escape
  // 2. Sau đó, thay thế tất cả các khoảng trắng còn lại thành ""
  const pemContents = pem
    .replace(pemHeader, "")
    .replace(pemFooter, "")
    .replace(/\\n/g, "") // Loại bỏ các ký tự xuống dòng đã bị escape
    .replace(/\s/g, "");  // Loại bỏ các khoảng trắng/xuống dòng còn lại

  // Giải mã Base64
  const binaryDer = atob(pemContents);
  
  // Chuyển đổi thành Uint8Array
  const keyData = new Uint8Array(binaryDer.length).map((_, i) => binaryDer.charCodeAt(i));
  
  // Import khóa
  return await crypto.subtle.importKey(
    "pkcs8",
    keyData,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    true,
    ["sign"],
  );
}

// Hàm để lấy Access Token
async function getGoogleAuthToken() {
  const serviceAccount = JSON.parse(Deno.env.get('GOOGLE_SERVICE_ACCOUNT_JSON')!);
  const privateKey = await importKey(serviceAccount.private_key);

  const header: Header = { alg: "RS256", typ: "JWT" };
  const payload = {
    iss: serviceAccount.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    exp: getNumericDate(3600), // Hết hạn sau 1 giờ
    iat: getNumericDate(0),
  };

  const jwt = await create(header, payload, privateKey);

  const response = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  const tokens = await response.json();
  if (!tokens.access_token) {
    throw new Error(`Failed to get access token: ${JSON.stringify(tokens)}`);
  }
  return tokens.access_token;
}

// Hàm serve chính (logic bên trong không thay đổi)
serve(async (req) => {
  try {
    const payload = await req.json();
    const message = payload.record;
    
    const serviceAccountJson = JSON.parse(Deno.env.get('GOOGLE_SERVICE_ACCOUNT_JSON')!);
    const GOOGLE_PROJECT_ID = serviceAccountJson.project_id;
    const FCM_API_URL = `https://fcm.googleapis.com/v1/projects/${GOOGLE_PROJECT_ID}/messages:send`;
    
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    );

    const { data: participants, error: pError } = await supabaseAdmin.from('conversation_participants').select('user_id').eq('conversation_id', message.conversation_id).neq('user_id', message.sender_id);
    if (pError || !participants || participants.length === 0) throw new Error("Recipient not found");
    const recipientId = participants[0].user_id;
    
    const { data: recipientProfile, error: rError } = await supabaseAdmin.from('profiles').select('fcm_tokens').eq('id', recipientId).single();
    const { data: senderProfile, error: sError } = await supabaseAdmin.from('profiles').select('id, username, display_name, photo_url').eq('id', message.sender_id).single();
    if (rError || sError) throw new Error("Could not fetch profiles");
    
    const fcmTokens = recipientProfile.fcm_tokens;
    if (!fcmTokens || fcmTokens.length === 0) {
      console.log(`Recipient ${recipientId} has no FCM tokens.`);
      return new Response("OK", { headers: { "Content-Type": "application/json" } });
    }

    const notificationTitle = senderProfile.display_name || senderProfile.username;
    const notificationBody = message.content 
        ? (message.content.length > 100 ? message.content.substring(0, 97) + '...' : message.content)
        : 'Đã gửi một bài viết';

    const fcmPayloads = fcmTokens.map((token: string) => ({
      message: {
        token: token,
        notification: { title: notificationTitle, body: notificationBody },
        android: { notification: { sound: 'default' } },
        apns: { payload: { aps: { sound: 'default' } } },
        data: {
          type: 'chat',
          conversationId: message.conversation_id,
          otherUserId: senderProfile.id,
          otherUserName: senderProfile.display_name,
          otherUserPhotoUrl: senderProfile.photo_url,
        },
      },
    }));
    
    const authToken = await getGoogleAuthToken();
    
    for (const payload of fcmPayloads) {
      const response = await fetch(FCM_API_URL, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });
      const responseBody = await response.json();
      if (!response.ok) {
         console.error(`FCM error for token ${payload.message.token}:`, responseBody);
      } else {
         console.log(`FCM response for token ${payload.message.token}:`, responseBody);
      }
    }

    return new Response(JSON.stringify({ success: true }), {
      headers: { "Content-Type": "application/json" },
    });

  } catch (error) {
    console.error('Error sending notification:', error);
    return new Response(JSON.stringify({ error: error instanceof Error ? error.message : "An unknown error occurred" }), {
      headers: { "Content-Type": "application/json" },
      status: 500,
    });
  }
});