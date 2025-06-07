import 'package:flutter/material.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài đăng mới'),
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Đăng'),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
