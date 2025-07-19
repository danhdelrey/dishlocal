import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:dishlocal/data/categories/post/model/review/review_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'review_event.dart';
part 'review_state.dart';
part 'review_bloc.freezed.dart';

@injectable
class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final _log = Logger('ReviewBloc');

  ReviewBloc() : super(const ReviewState.initial()) {
    on<_Initialized>(_onInitialized);
    on<_RatingChanged>(_onRatingChanged);
    on<_ChoiceToggled>(_onChoiceToggled);
  }

  /// Xử lý việc khởi tạo trạng thái ban đầu.
  void _onInitialized(_Initialized event, Emitter<ReviewState> emit) {
    _log.info('Initializing ReviewBloc...');
    // Tạo một Map để chứa dữ liệu đánh giá cho từng hạng mục.
    final initialData = <ReviewCategory, ReviewItem>{};

    // Duyệt qua tất cả các hạng mục có trong enum ReviewCategory.
    for (final category in ReviewCategory.values) {
      // Tìm xem có dữ liệu ban đầu cho hạng mục này không (trường hợp chỉnh sửa).
      final existingItem = event.initialReviews.where((item) => item.category == category).firstOrNull;

      // Nếu có, dùng dữ liệu đó. Nếu không, tạo một ReviewItem rỗng.
      initialData[category] = existingItem ?? ReviewItem(category: category);
    }

    emit(ReviewState.ready(
      reviewData: initialData,
      isSubmittable: _isSubmittable(initialData),
    ));
  }

  /// Xử lý khi người dùng thay đổi số sao.
  void _onRatingChanged(_RatingChanged event, Emitter<ReviewState> emit) {
    // Chỉ xử lý nếu state hiện tại là `ready`.
    final currentState = state;
    if (currentState is! Ready) return;

    _log.info('Rating changed for ${event.category.name} to ${event.newRating}');

    // Tạo một bản sao của Map dữ liệu để đảm bảo tính bất biến (immutability).
    final newReviewData = Map<ReviewCategory, ReviewItem>.from(currentState.reviewData);

    // Lấy ra item cần cập nhật.
    final itemToUpdate = newReviewData[event.category]!;
    final newRatingInt = event.newRating.round();

    // <<<--- LOGIC MỚI QUAN TRỌɢ ---
    // Cập nhật item với rating mới VÀ xóa sạch danh sách lựa chọn cũ.
    // Điều này đảm bảo khi người dùng đổi từ 5 sao (với các choice A, B)
    // sang 1 sao, các choice A, B sẽ bị xóa đi.
    newReviewData[event.category] = itemToUpdate.copyWith(
      rating: newRatingInt,
      selectedChoices: [], // Xóa sạch các lựa chọn cũ
    );
    // -------------------------------->

    // Phát ra trạng thái mới với dữ liệu đã được cập nhật.
    emit(currentState.copyWith(
      reviewData: newReviewData,
      isSubmittable: _isSubmittable(newReviewData), // Kiểm tra lại điều kiện submit
    ));
  }

  /// Xử lý khi người dùng chọn/bỏ chọn một lựa chọn.
  void _onChoiceToggled(_ChoiceToggled event, Emitter<ReviewState> emit) {
    final currentState = state;
    if (currentState is! Ready) return;

    _log.info('Choice toggled for ${event.category.name}: ${event.choice.name}');

    final newReviewData = Map<ReviewCategory, ReviewItem>.from(currentState.reviewData);
    final itemToUpdate = newReviewData[event.category]!;

    // Tạo một bản sao của danh sách các lựa chọn đã chọn.
    final currentChoices = List<ReviewChoice>.from(itemToUpdate.selectedChoices);

    // Nếu lựa chọn đã tồn tại, hãy xóa nó đi. Ngược lại, thêm nó vào.
    if (currentChoices.contains(event.choice)) {
      currentChoices.remove(event.choice);
    } else {
      currentChoices.add(event.choice);
    }

    // Cập nhật item với danh sách lựa chọn mới.
    newReviewData[event.category] = itemToUpdate.copyWith(selectedChoices: currentChoices);

    // Phát ra trạng thái mới.
    emit(currentState.copyWith(reviewData: newReviewData));
  }

  /// Hàm tiện ích để kiểm tra xem có thể submit được chưa.
  /// Điều kiện: Ít nhất một hạng mục phải có rating > 0.
  bool _isSubmittable(Map<ReviewCategory, ReviewItem> data) {
    return data.values.any((item) => item.rating > 0);
  }
}
