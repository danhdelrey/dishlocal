import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:dishlocal/ui/features/review/bloc/review_bloc.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewSection extends StatefulWidget {
  const ReviewSection({super.key});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  // Cung cấp BLoC cho widget này và các con của nó.
  // Nhớ dispose BLoC khi widget bị hủy.
  final _reviewBloc = getIt<ReviewBloc>(); // Hoặc lấy từ Injectable/GetIt

  @override
  void initState() {
    super.initState();
    // Thêm sự kiện khởi tạo ngay khi widget được tạo.
    // Nếu bạn đang edit bài post, hãy truyền dữ liệu review cũ vào đây.
    _reviewBloc.add(const ReviewEvent.initialized());
  }

  @override
  void dispose() {
    _reviewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dùng BlocProvider để cung cấp BLoC
    return BlocProvider.value(
      value: _reviewBloc,
      // Dùng BlocBuilder để lắng nghe thay đổi state và rebuild UI
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          // Hiển thị loading indicator nếu state chưa sẵn sàng
          if (state is! Ready) {
            return const Center(child: CircularProgressIndicator());
          }

          // Khi state đã sẵn sàng, `state.reviewData` sẽ chứa dữ liệu
          final reviewData = state.reviewData;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ReviewCategory.values.map((category) {
                // Lấy ra ReviewItem tương ứng với category hiện tại
                final item = reviewData[category]!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.label,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      RatingBar.builder(
                        glow: false,
                        // Lấy rating từ state
                        initialRating: item.rating.toDouble(),
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false, // Để rating là số nguyên
                        itemCount: 5,
                        itemSize: 24,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // Gửi sự kiện tới BLoC khi rating thay đổi
                          context.read<ReviewBloc>().add(
                                ReviewEvent.ratingChanged(
                                  category: category,
                                  newRating: rating,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: category.availableChoices.map((choice) {
                          // Kiểm tra xem choice này có được chọn không từ state
                          final isSelected = item.selectedChoices.contains(choice);

                          return CustomChoiceChip(
                            borderRadius: 8,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            label: choice.label,
                            isSelected: isSelected, // Cập nhật từ state
                            onSelected: (selected) {
                              // Gửi sự kiện tới BLoC khi choice được toggle
                              context.read<ReviewBloc>().add(
                                    ReviewEvent.choiceToggled(
                                      category: category,
                                      choice: choice,
                                    ),
                                  );
                            },
                            itemColor: category.color,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
