import 'package:dishlocal/ui/features/share_post/view/share_post_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final String postId;

  const ShareButton({super.key, required this.postId});

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Quan trọng cho DraggableScrollableSheet
      backgroundColor: Colors.transparent, // Nền trong suốt để bo góc
      builder: (_) => SharePostBottomSheet(postId: postId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () => _showShareSheet(context),
    );
  }
}
