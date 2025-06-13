import 'package:dishlocal/ui/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionChecker extends StatefulWidget {
  const InternetConnectionChecker({
    super.key,
    required this.builder,
    this.loadingWidget,
  });

  /// Builder function để trả về widget tương ứng với trạng thái kết nối.
  final Widget Function(bool hasInternetAccess) builder;

  /// Widget sẽ hiển thị trong khi đang kiểm tra kết nối.
  /// Nếu không cung cấp, một widget loading mặc định sẽ được sử dụng.
  final Widget? loadingWidget;

  @override
  State<InternetConnectionChecker> createState() => _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  // Sử dụng kiểu bool? (nullable) để biểu diễn 3 trạng thái:
  // null: Đang kiểm tra
  // true: Có kết nối
  // false: Không có kết nối
  bool? _hasInternetAccess;

  @override
  void initState() {
    super.initState();
    // Gọi hàm kiểm tra kết nối ngay khi widget được tạo
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    // Sử dụng thư viện để kiểm tra. Bạn có thể thay bằng thư viện khác.
    final result = await InternetConnection().hasInternetAccess;

    // Quan trọng: Kiểm tra xem widget còn tồn tại trong cây widget không
    // trước khi gọi setState để tránh lỗi.
    if (mounted) {
      setState(() {
        _hasInternetAccess = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu _hasInternetAccess là null, có nghĩa là chúng ta đang chờ kết quả
    if (_hasInternetAccess == null) {
      return widget.loadingWidget ??
          const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Kiểm tra kết nối...',
            ),
          );
    }

    // Khi đã có kết quả (true hoặc false), gọi builder function
    // với kết quả đó.
    return widget.builder(_hasInternetAccess!);
  }
}
