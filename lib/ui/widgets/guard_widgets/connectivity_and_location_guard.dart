import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ConnectivityAndLocationGuard extends StatefulWidget {
  final WidgetBuilder builder;

  const ConnectivityAndLocationGuard({super.key, required this.builder});

  @override
  State<ConnectivityAndLocationGuard> createState() => _ConnectivityAndLocationGuardState();
}

class _ConnectivityAndLocationGuardState extends State<ConnectivityAndLocationGuard> {
  // Các stream subscription
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  // MỚI: Thêm subscription để lắng nghe dịch vụ vị trí
  late StreamSubscription<ServiceStatus> _locationServiceSubscription;

  // Các biến trạng thái
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  bool _isLocationServiceEnabled = false;
  LocationPermission _locationPermission = LocationPermission.denied;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi kết nối mạng
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _updateConnectivityStatus(result);
      });
    });

    // MỚI: Lắng nghe thay đổi trạng thái dịch vụ vị trí (GPS)
    _locationServiceSubscription = Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      setState(() {
        _isLocationServiceEnabled = (status == ServiceStatus.enabled);
      });
    });

    // Kiểm tra trạng thái ban đầu
    _checkInitialStatus();
  }

  @override
  void dispose() {
    // Hủy tất cả các subscription để tránh rò rỉ bộ nhớ
    _connectivitySubscription.cancel();
    _locationServiceSubscription.cancel(); // MỚI
    super.dispose();
  }

  // Hàm helper để xử lý logic lặp lại cho connectivity
  void _updateConnectivityStatus(List<ConnectivityResult> result) {
    // Coi là mất mạng nếu list chỉ chứa 'none' hoặc rỗng.
    if (result.contains(ConnectivityResult.none) && result.length == 1) {
      _connectivityResult = ConnectivityResult.none;
    } else {
      // Ưu tiên lấy một kết quả có giá trị (ví dụ: wifi, mobile) để đại diện
      _connectivityResult = result.firstWhere(
        (r) => r != ConnectivityResult.none,
        orElse: () => ConnectivityResult.none,
      );
    }
  }

  Future<void> _checkInitialStatus() async {
    // Chạy đồng thời các tác vụ bất đồng bộ để nhanh hơn
    final results = await Future.wait([
      Connectivity().checkConnectivity(),
      Geolocator.isLocationServiceEnabled(),
      Geolocator.checkPermission(),
    ]);

    setState(() {
      _updateConnectivityStatus(results[0] as List<ConnectivityResult>);
      _isLocationServiceEnabled = results[1] as bool;
      _locationPermission = results[2] as LocationPermission;
      _isLoading = false;
    });
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Nếu người dùng từ chối vĩnh viễn, mở cài đặt ứng dụng
      await Geolocator.openAppSettings();
    }
    // Tải lại toàn bộ trạng thái sau khi yêu cầu quyền
    // vì người dùng có thể đã vào cài đặt và thay đổi cả dịch vụ vị trí
    await _checkInitialStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 1. Ưu tiên kiểm tra quyền trước
    if (_locationPermission == LocationPermission.denied || _locationPermission == LocationPermission.deniedForever) {
      return _buildPermissionDeniedUI();
    }

    // 2. Kiểm tra các dịch vụ
    if (_connectivityResult == ConnectivityResult.none || !_isLocationServiceEnabled) {
      return _buildServiceDisabledUI();
    }

    // Nếu mọi thứ đều ổn, hiển thị nội dung chính
    return widget.builder(context);
  }

  // --- Các hàm build UI không thay đổi ---

  Widget _buildPermissionDeniedUI() {
    String message = "Ứng dụng cần quyền truy cập vị trí để có thể hoạt động. "
        "Vui lòng cấp quyền.";
    if (_locationPermission == LocationPermission.deniedForever) {
      message = "Bạn đã từ chối quyền truy cập vị trí vĩnh viễn. "
          "Vui lòng vào cài đặt ứng dụng để cấp quyền.";
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.locationOffFilled.toSvg(
                width: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: appTextTheme(context).titleMedium,
              ),
              const SizedBox(height: 24),
              GradientFilledButton(
                icon: Icon(
                  _locationPermission == LocationPermission.deniedForever ? Icons.settings : Icons.location_on,
                  color: Colors.white,
                ),
                label: _locationPermission == LocationPermission.deniedForever ? "Mở Cài Đặt" : "Cấp quyền",
                onTap: _requestLocationPermission,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDisabledUI() {
    final hasInternet = _connectivityResult != ConnectivityResult.none;
    final hasLocationService = _isLocationServiceEnabled;

    List<String> issues = [];
    if (!hasInternet) {
      issues.add("kết nối mạng");
    }
    if (!hasLocationService) {
      issues.add("dịch vụ vị trí (GPS)");
    }

    final message = "Vui lòng bật ${issues.join(' và ')} để tiếp tục sử dụng ứng dụng.";

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sử dụng AppIcons thay vì Material Icons
              !hasInternet
                  ? Icon(
                      CupertinoIcons.wifi_exclamationmark,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(
                      CupertinoIcons.location_slash_fill,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: appTextTheme(context).titleMedium,
              ),
              const SizedBox(height: 24),
              // Sử dụng primary gradient cho button
              GradientFilledButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: 'Tải lại',
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _checkInitialStatus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
