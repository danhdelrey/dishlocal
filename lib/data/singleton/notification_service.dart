import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: AppEnvironment.firebaseOption,
  );
  // Sử dụng log thay vì print để có định dạng tốt hơn
  log("Handling a background message: ${message.messageId}", name: "_firebaseMessagingBackgroundHandler");
}

@lazySingleton
class NotificationService {
  final _log = Logger('NotificationService');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final AppUserRepository _userRepository;
  final AppRouteObserver _routeObserver;

  // Giữ lại các subscription để có thể hủy khi cần
  StreamSubscription? _onMessageSubscription;
  StreamSubscription? _onMessageOpenedAppSubscription;
  StreamSubscription? _onTokenRefreshSubscription;

  NotificationService(this._userRepository, this._routeObserver);

  // === CÁC PHƯƠNG THỨC QUẢN LÝ VÒNG ĐỜI ===

  /// 1. Khởi tạo các thành phần chỉ cần chạy một lần khi app khởi động.
  /// Gọi hàm này trong main.dart.
  Future<void> initAppLevelSetup() async {
    _log.info('🔔 Initializing App-Level Notification Setup...');
    // Lắng nghe thông báo ở background trước tiên
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Thiết lập kênh thông báo local
    await _setupLocalNotifications();
  }

  /// 2. Khởi tạo các thành phần phụ thuộc vào người dùng (sau khi đăng nhập).
  /// Sẽ được gọi bởi AuthBloc.
  Future<void> initUserLevelSetup() async {
    _log.info('🚀 Initializing User-Level Notification Setup...');
    // Yêu cầu quyền
    await _firebaseMessaging.requestPermission();
    // Lấy và cập nhật FCM token
    await _handleFcmToken();
    // Thiết lập các listener cho trạng thái foreground và background
    _setupMessageListeners();
  }

  /// 3. Dọn dẹp các tài nguyên liên quan đến người dùng khi đăng xuất.
  /// Sẽ được gọi bởi AuthBloc.
  Future<void> disposeUserLevelSetup() async {
    _log.info('🧹 Disposing User-Level Notification Setup...');
    // Hủy tất cả các listener
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedAppSubscription?.cancel();
    await _onTokenRefreshSubscription?.cancel();
    _onMessageSubscription = null;
    _onMessageOpenedAppSubscription = null;
    _onTokenRefreshSubscription = null;

    // (Tùy chọn) Xóa token trên server để không gửi thông báo đến thiết bị đã đăng xuất
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) await _userRepository.removeFcmToken(fcmToken);
  }

  /// 4. Xử lý thông báo đã mở ứng dụng từ trạng thái bị đóng.
  /// Gọi trong initState của widget App chính.
  Future<void> handleInitialMessage() async {
    final RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _log.info('📱 Handling initial message from terminated state: ${initialMessage.data}');
      // Thêm độ trễ nhỏ để đảm bảo GoRouter đã sẵn sàng
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleNotificationTap(initialMessage.data);
      });
    }
  }

  // === CÁC PHƯƠNG THỨC PRIVATE HELPER ===

  Future<void> _handleFcmToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        _log.info("📱 FCM Token: $fcmToken");
        await _userRepository.updateFcmToken(fcmToken);
      } else {
        _log.warning("❗ FCM Token is null.");
      }

      // Hủy listener cũ trước khi tạo mới
      await _onTokenRefreshSubscription?.cancel();
      _onTokenRefreshSubscription = _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _log.info("🔄 FCM Token Refreshed: $newToken");
        _userRepository.updateFcmToken(newToken);
      });
    } catch (e) {
      _log.severe("Error handling FCM token: $e");
    }
  }

  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          try {
            final Map<String, dynamic> data = json.decode(response.payload!);
            _handleNotificationTap(data);
          } catch (e) {
            _log.severe("Error parsing local notification payload: $e", response.payload);
          }
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  void _setupMessageListeners() {
    // Hủy các listener cũ để đảm bảo không bị nhân đôi
    _onMessageSubscription?.cancel();
    _onMessageOpenedAppSubscription?.cancel();

    _onMessageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _log.info('Foreground message received: ${message.notification?.title}');

      final conversationId = message.data['conversationId'];
      if (conversationId != null && _routeObserver.isInsideChatScreen(conversationId)) {
        _log.info("User is in the target chat screen. Suppressing notification.");
        return;
      }

      final notification = message.notification;
      if (notification != null) {
        String? largeIconPath;
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
              largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    });

    _onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _log.info('Notification tapped (app in background): ${message.data}');
      _handleNotificationTap(message.data);
    });
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    final String? type = data['type'] as String?;
    _log.info('Handling notification tap with type: $type');

    // Sử dụng context từ GlobalKey để đảm bảo an toàn
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context == null) {
      _log.severe('Cannot handle notification tap: root navigator context is null.');
      return;
    }

    if (type == 'chat') {
      final conversationId = data['conversationId'] as String?;
      final otherUserId = data['otherUserId'] as String?;
      if (conversationId != null && otherUserId != null) {
        final otherUser = AppUser.fromJson(Map<String, dynamic>.from(data)); // Giả sử data chứa đủ trường
        context.push('/chat', extra: {'conversationId': conversationId, 'otherUser': otherUser});
      }
    } else if (type == 'new_post') {
      final postId = data['postId'] as String?;
      if (postId != null) context.push('/post/$postId');
    } else {
      context.go('/home');
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getTemporaryDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void clearAllChatNotifications() {
    _log.info("Clearing all app notifications...");
    _localNotifications.cancelAll();
  }
}
