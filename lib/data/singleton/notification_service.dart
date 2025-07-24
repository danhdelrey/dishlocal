import 'dart:convert';
import 'dart:io';

import 'package:dishlocal/app/config/app_router.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/singleton/app_route_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: AppEnvironment.firebaseOption,
  );
  Logger("_firebaseMessagingBackgroundHandler").info("Handling a background message: ${message.messageId}");
}


@lazySingleton
class NotificationService {
  final _log = Logger('NotificationService');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final AppUserRepository _userRepository;
  final AppRouteObserver _routeObserver;
  final GoRouter _router;

  NotificationService(this._userRepository, this._routeObserver, this._router);

  /// Khởi tạo toàn bộ dịch vụ thông báo.
  /// Gọi hàm này trong main.dart sau khi khởi tạo Firebase.
  Future<void> initialize() async {
    // 1. Yêu cầu quyền

    // 2. Lấy và quản lý FCM token
    await _handleFcmToken();

    // 3. Thiết lập thông báo Local (cho Android khi app đang mở)
    await _setupLocalNotifications();

    // 4. Lắng nghe các sự kiện thông báo
    _setupMessageListeners();
  }

  /// Yêu cầu quyền gửi thông báo từ người dùng.
  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// Lấy FCM token và gửi lên server nếu cần.
  Future<void> _handleFcmToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      _log.info("📱 FCM Token: $fcmToken");
      // Gửi token lên server để lưu vào bảng profiles
      // Giả sử AppUserRepository có phương thức này
      await _userRepository.updateFcmToken(fcmToken);
    }else{
      _log.warning("❗ FCM Token is null. Please check your Firebase configuration.");
    }

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _log.info("🔄 FCM Token Refreshed: $newToken");
      _userRepository.updateFcmToken(newToken);
    });
  }

  /// Thiết lập cho thông báo local (hiển thị khi app đang chạy ở foreground).
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          // Thêm kiểm tra isNotEmpty
          try {
            // === THAY ĐỔI QUAN TRỌNG ===
            // Bây giờ chúng ta có thể decode trực tiếp
            final Map<String, dynamic> data = json.decode(response.payload!);
            _handleNotificationTap(data);
          } catch (e) {
            _log.info("Error parsing local notification payload: $e");
            _log.info("Payload content: ${response.payload}"); // In ra payload để gỡ lỗi
          }
        }
      },
    );

    // Tạo một Notification Channel cho Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getTemporaryDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /// Lắng nghe các loại thông báo khác nhau từ FCM.
  void _setupMessageListeners() {
    // 1. Khi ứng dụng đang mở (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // <-- Thêm async
      _log.info('🔔 Message received in foreground: ${message.data}');

      final conversationId = message.data['conversationId'];

      // === YÊU CẦU: Nếu đang trong route chat thì không hiện thông báo ===
      if (conversationId != null && _routeObserver.isInsideChatScreen(conversationId)) {
        _log.info("User is already in the target chat screen. Suppressing notification.");
        return; // Không làm gì cả
      }

      final notification = message.notification;
      if (notification != null) {
        // === YÊU CẦU: Hiển thị avatar của người gửi ===
        String? largeIconPath;
        // Lấy URL ảnh từ payload của Android/APNS
        final imageUrl = message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl;
        if (imageUrl != null) {
          largeIconPath = await _downloadAndSaveFile(imageUrl, 'largeIcon');
        }

        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              icon: '@mipmap/ic_launcher',
              // Thêm avatar vào đây
              largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
            ),
          ),
          payload: json.encode(message.data), // Gửi data dưới dạng chuỗi JSON
        );
      }
    });


    // 2. Khi người dùng nhấn vào thông báo (App ở background nhưng chưa bị đóng)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _log.info('🔔 Notification tapped (app in background): ${message.data}');
      _handleNotificationTap(message.data);
    });

    // 3. Xử lý thông báo đã mở ứng dụng từ trạng thái bị đóng (Terminated)
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _log.info('🔔 Notification tapped (app was terminated): ${message.data}');
        _handleNotificationTap(message.data);
      }
    });

    // 4. Lắng nghe thông báo ở background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    // Ép kiểu an toàn
    final String? type = data['type'] as String?;
    _log.info('Handling notification tap with type: $type');

    // Xử lý thông báo CHAT
    if (type == 'chat') {
      final String? conversationId = data['conversationId'] as String?;
      final String? otherUserId = data['otherUserId'] as String?;
      final String? otherUserName = data['otherUserName'] as String?;
      final String? otherUserPhotoUrl = data['otherUserPhotoUrl'] as String?;

      if (conversationId != null && otherUserId != null) {
        _log.info('Navigating to chat with conversationId: $conversationId');

        // Tạo một object AppUser từ dữ liệu trong thông báo.
        // Cung cấp các giá trị mặc định cho các trường không có trong payload.
        final AppUser otherUser = AppUser(
          userId: otherUserId,
          displayName: otherUserName,
          photoUrl: otherUserPhotoUrl,
          username: data['otherUsername'] as String? ?? '', // Giả sử có thể có username
          isSetupCompleted: true, // Giả định người dùng đã hoàn tất setup
        );

        final context = AppRouter.rootNavigatorKey.currentContext;
        if (context != null) {
          context.push(
            '/chat',
            extra: {
              'conversationId': conversationId,
              'otherUser': otherUser,
            },
          );
        } else {
          _log.info('Error: rootNavigatorKey.currentContext is null. Cannot navigate.');
        }
      } else {
        _log.info('Warning: Missing conversationId or otherUserId in chat notification payload.');
      }
    }

    // Xử lý thông báo BÀI VIẾT (trong tương lai)
    else if (type == 'new_post') {
      final String? postId = data['postId'] as String?;

      if (postId != null) {
        _log.info('Navigating to post with postId: $postId');

        // Điều hướng đến màn hình chi tiết bài viết.
        // Giả sử route của bạn có dạng /post/:postId
        
      } else {
        _log.info('Warning: Missing postId in new_post notification payload.');
      }
    }

    // Xử lý các loại thông báo khác
    else {
      _log.info('Warning: Received notification tap with unknown or missing type: $type');
      // Có thể điều hướng về trang chủ như một giải pháp dự phòng
      _router.go('/home');
    }
  }
}
