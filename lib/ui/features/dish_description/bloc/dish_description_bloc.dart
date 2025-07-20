import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/generated_content/repository/interface/generated_content_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'dish_description_event.dart';
part 'dish_description_state.dart';
part 'dish_description_bloc.freezed.dart';

@injectable
class DishDescriptionBloc extends Bloc<DishDescriptionEvent, DishDescriptionState> {
  final _log = Logger('DishDescriptionBloc');
  final GeneratedContentRepository _generatedContentRepository;

  DishDescriptionBloc(this._generatedContentRepository) : super(const DishDescriptionState.initial()) {
    // Đăng ký trình xử lý cho sự kiện generateRequested
    on<_GenerateDescriptionRequested>(_onGenerateDescriptionRequested);
  }

  /// Xử lý sự kiện khi người dùng yêu cầu tạo mô tả.
  Future<void> _onGenerateDescriptionRequested(
    _GenerateDescriptionRequested event,
    Emitter<DishDescriptionState> emit,
  ) async {
    _log.info('Nhận được yêu cầu tạo mô tả cho món: "${event.dishName}"');

    // 1. Phát ra trạng thái loading để UI hiển thị chỉ báo tải
    emit(const DishDescriptionState.loading());

    // 2. Gọi repository để lấy dữ liệu
    final result = await _generatedContentRepository.generateDishDescription(
      imageUrl: event.imageUrl,
      dishName: event.dishName,
    );

    // 3. Xử lý kết quả trả về từ repository
    result.fold(
      // 3a. Nếu thất bại (Left)
      (failure) {
        _log.warning('Tạo mô tả thất bại: ${failure.message}');
        emit(DishDescriptionState.failure(errorMessage: failure.message));
      },
      // 3b. Nếu thành công (Right)
      (content) {
        _log.info('Tạo mô tả thành công!');
        emit(DishDescriptionState.success(description: content.generatedContent));
      },
    );
  }
}
