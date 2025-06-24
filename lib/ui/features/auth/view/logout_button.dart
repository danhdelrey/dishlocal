import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Gửi event 'SignedOut' đến AuthBloc để bắt đầu quá trình đăng xuất.
        context.read<AuthBloc>().add(const AuthEvent.signedOut());
      },
      icon: const Icon(Icons.logout_rounded),
    );
  }
}
