import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout_rounded),
      onPressed: () async {
        // 1. Chuyển hàm onPressed thành `async`
        // 2. Hiển thị hộp thoại và chờ kết quả từ người dùng
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Xác nhận đăng xuất'),
              content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
              actions: <Widget>[
                // Nút "Hủy"
                TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    // Đóng hộp thoại và trả về `false`
                    Navigator.of(dialogContext).pop(false);
                  },
                ),
                // Nút "Đăng xuất"
                TextButton(
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: Colors.red), // Thêm màu để nhấn mạnh
                  ),
                  onPressed: () {
                    // Đóng hộp thoại và trả về `true`
                    Navigator.of(dialogContext).pop(true);
                  },
                ),
              ],
            );
          },
        );

        // 3. Kiểm tra kết quả sau khi hộp thoại đóng
        // Chỉ thực hiện đăng xuất nếu người dùng đã nhấn "Đăng xuất" (confirm == true)
        // Dùng `context.mounted` để đảm bảo widget vẫn còn tồn tại sau lệnh await
        if (confirm == true && context.mounted) {
          // Gửi event 'SignedOut' đến AuthBloc để bắt đầu quá trình đăng xuất.
          context.read<AuthBloc>().add(const AuthEvent.signedOut());
        }
      },
    );
  }
}
