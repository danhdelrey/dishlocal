import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  NotificationService(this._userRepository);

  /// Khởi tạo toàn bộ dịch vụ thông báo.
  /// Gọi hàm này trong main.dart sau khi khởi tạo Firebase.
  Future<void> initialize() async {
    // 1. Yêu cầu quyền
    await _requestPermission();

    // 2. Lấy và quản lý FCM token
    await _handleFcmToken();

    // 3. Thiết lập thông báo Local (cho Android khi app đang mở)
    await _setupLocalNotifications();

    // 4. Lắng nghe các sự kiện thông báo
    _setupMessageListeners();
  }

  /// Yêu cầu quyền gửi thông báo từ người dùng.
  Future<void> _requestPermission() async {
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
    await _localNotifications.initialize(initializationSettings);

    // Tạo một Notification Channel cho Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  /// Lắng nghe các loại thông báo khác nhau từ FCM.
  void _setupMessageListeners() {
    // 1. Khi ứng dụng đang mở (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _log.info('🔔 Message received in foreground: ${message.notification?.title}');
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        // Hiển thị thông báo local để người dùng thấy
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id kênh
              'High Importance Notifications',
              icon: android.smallIcon,
            ),
          ),
          payload: message.data.toString(), // Truyền dữ liệu vào payload
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

  /// Xử lý _log.infoic điều hướng khi người dùng nhấn vào thông báo.
  void _handleNotificationTap(Map<String, dynamic> data) {
    final String? type = data['type']; // 'chat', 'new_post', 'like', etc.

    if (type == 'chat') {
      final String? conversationId = data['conversationId'];
      final String? otherUserName = data['otherUserName'];
      final String? otherUserPhotoUrl = data['otherUserPhotoUrl'];
      final String? otherUserId = data['otherUserId'];

      if (conversationId != null && otherUserId != null) {
        // TODO: Sử dụng GoRouter hoặc hệ thống điều hướng của bạn
        // để chuyển đến màn hình ChatScreen với các thông tin này.
        // Ví dụ:
        // AppRouter.instance.push('/chat', extra: { ... });
        _log.info('Navigate to chat with conversationId: $conversationId');
      }
    } else if (type == 'new_post') {
      final String? postId = data['postId'];
      // TODO: Điều hướng đến màn hình chi tiết bài post
      _log.info('Navigate to post with postId: $postId');
    }
  }
}
