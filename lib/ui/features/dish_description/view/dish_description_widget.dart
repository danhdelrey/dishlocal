import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/dish_description/bloc/dish_description_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DishDescriptionWidget extends StatelessWidget {
  final String dishName;
  final String imageUrl;

  const DishDescriptionWidget({
    super.key,
    required this.dishName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DishDescriptionBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    dishName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Widget nút "?" được viết lại bên dưới
                _GenerateButton(
                  dishName: dishName,
                  imageUrl: imageUrl,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Widget nội dung mô tả được viết lại bên dưới
            _DescriptionContent(),
          ],
        ),
      ),
    );
  }
}

//--- CÁC WIDGET CON ĐƯỢC VIẾT LẠI ---

/// Widget nút "?", được viết lại sử dụng câu lệnh `if/else`.
class _GenerateButton extends StatelessWidget {
  final String dishName;
  final String imageUrl;

  const _GenerateButton({
    required this.dishName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi state của Bloc
    final state = context.watch<DishDescriptionBloc>().state;

    // Sử dụng if/else để quyết định có hiển thị nút hay không.
    // Nút chỉ hiển thị ở trạng thái ban đầu hoặc khi có lỗi,
    // cho phép người dùng thử lại.
    if (state is DishDescriptionInitial || state is DishDescriptionFailure) {
      return IconButton(
        icon: const Icon(Icons.help_outline, color: Colors.blue),
        tooltip: 'Lấy thông tin món ăn bằng AI',
        onPressed: () {
          context.read<DishDescriptionBloc>().add(
                DishDescriptionEvent.generateRequested(
                  imageUrl: imageUrl,
                  dishName: dishName,
                ),
              );
        },
      );
    } else {
      // Ở các trạng thái khác (loading, success), ẩn nút đi.
      return const SizedBox.shrink();
    }
  }
}

/// Widget hiển thị nội dung mô tả, được viết lại sử dụng câu lệnh `switch`.
/// Đây là cách tiếp cận hiện đại và được khuyến khích với Dart 3+.
class _DescriptionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi state của Bloc
    final state = context.watch<DishDescriptionBloc>().state;

    // Sử dụng switch với pattern matching để render UI tương ứng cho mỗi state.
    // Cách này rất an toàn vì trình biên dịch sẽ báo lỗi nếu bạn bỏ sót một state nào đó.
    switch (state) {
      // Case 1: Trạng thái đang tải
      case DishDescriptionLoading():
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: CircularProgressIndicator(),
          ),
        );

      // Case 2: Trạng thái thành công
      // Pattern matching cho phép ta trích xuất trực tiếp thuộc tính `description`
      case DishDescriptionSuccess(description: final desc):
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
          ),
          child: Text(
            desc,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[800]),
          ),
        );

      // Case 3: Trạng thái thất bại
      // Tương tự, ta trích xuất `errorMessage`
      case DishDescriptionFailure(errorMessage: final msg):
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Lỗi: $msg',
            style: const TextStyle(fontSize: 14, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );

      // Case 4: Các trạng thái còn lại (ở đây chỉ còn `_Initial`)
      // Trả về một widget trống.
      case DishDescriptionInitial():
        return const SizedBox();
    }
  }
}
