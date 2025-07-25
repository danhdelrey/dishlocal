import 'dart:async';

import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/dish_description/bloc/dish_description_bloc.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên món ăn
          Text(
            dishName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Nút bấm hoặc nội dung mô tả sẽ xuất hiện ở đây
          // Chúng ta sử dụng một Builder để lấy context có chứa BlocProvider
          Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget nút, chỉ hiển thị khi cần
                _InfoButton(
                  dishName: dishName,
                  imageUrl: imageUrl,
                ),
                // Widget nội dung mô tả, thay đổi theo state
                _DescriptionContent(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

//--- CÁC WIDGET CON ĐƯỢC THIẾT KẾ LẠI THEO YÊU CẦU ---

/// Widget nút "Thông tin món ăn"
/// Chỉ hiển thị ở trạng thái ban đầu hoặc khi có lỗi để cho phép thử lại.
class _InfoButton extends StatelessWidget {
  final String dishName;
  final String imageUrl;

  const _InfoButton({
    required this.dishName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DishDescriptionBloc>().state;

    // Chỉ hiển thị nút ở trạng thái Initial hoặc Failure
    if (state is DishDescriptionInitial || state is DishDescriptionFailure) {
      return Material(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: primaryGradient,
          ),
          padding: const EdgeInsets.all(1), // viền gradient mỏng
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              context.read<DishDescriptionBloc>().add(
                    DishDescriptionEvent.generateRequested(
                      imageUrl: imageUrl,
                      dishName: dishName,
                    ),
                  );
            },
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.sparkles,
                    color: appColorScheme(context).primary,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  ShaderMask(
                    shaderCallback: (bounds) => primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "Tìm hiểu món ăn này",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white, // màu này sẽ bị gradient che phủ
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Ẩn nút ở các trạng thái khác
    return const SizedBox.shrink();
  }
}

/// Widget hiển thị nội dung, thay đổi linh hoạt theo state của Bloc
class _DescriptionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<DishDescriptionBloc>().state;

    // Sử dụng switch expression (Dart 3+) để render UI một cách an toàn và gọn gàng
    return switch (state) {
      // Khi đang tải: Hiển thị hiệu ứng shimmer
      DishDescriptionLoading() => const _ShimmerEffect(),

      // Khi thành công: Hiển thị text với animation từng từ
      DishDescriptionSuccess(description: final desc) => Column(
          children: [
            FadeSlideUp(
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: appColorScheme(context).outline, size: 12),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Nội dung được gợi ý bởi AI – chỉ mang tính tham khảo.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: appColorScheme(context).outline,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            _AnimatedDescriptionText(fullText: desc),
          ],
        ),

      // Khi thất bại: Hiển thị thông báo lỗi
      DishDescriptionFailure(errorMessage: final msg) => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Đã xảy ra lỗi. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),

      // Trạng thái ban đầu: Không hiển thị gì
      DishDescriptionInitial() => const SizedBox.shrink(),
    };
  }
}

/// Widget hiệu ứng Shimmer khi đang tải
class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect();

  @override
  Widget build(BuildContext context) {
    return FadeSlideUp(
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFfc6076),
        highlightColor: const Color(0xFFff9a44),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.sparkles,
              color: appColorScheme(context).onSurface,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              "Đang lấy mô tả từ AI...",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: appColorScheme(context).onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget hiển thị mô tả với animation từng từ
class _AnimatedDescriptionText extends StatefulWidget {
  final String fullText;

  const _AnimatedDescriptionText({required this.fullText});

  @override
  State<_AnimatedDescriptionText> createState() => _AnimatedDescriptionTextState();
}

class _AnimatedDescriptionTextState extends State<_AnimatedDescriptionText> {
  late List<String> _words;
  String _displayedText = '';
  int _currentWordIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _words = widget.fullText.split(' ');
    _startAnimation();
  }

  void _startAnimation() {
    // Tốc độ animation (ms/từ)
    const animationSpeed = Duration(milliseconds: 10);

    _timer = Timer.periodic(animationSpeed, (timer) {
      if (_currentWordIndex < _words.length) {
        setState(() {
          _displayedText += '${_words[_currentWordIndex]} ';
          _currentWordIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    // Quan trọng: Huỷ timer để tránh rò rỉ bộ nhớ
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: Theme.of(context).textTheme.bodyMedium);
  }
}
