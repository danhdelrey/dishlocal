import 'package:bloc/bloc.dart';
import 'package:dishlocal/core/enum/food_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'select_food_category_event.dart';
part 'select_food_category_state.dart';
part 'select_food_category_bloc.freezed.dart';

@injectable
class SelectFoodCategoryBloc extends Bloc<SelectFoodCategoryEvent, SelectFoodCategoryState> {
  SelectFoodCategoryBloc() : super(const SelectFoodCategoryState.initial()) {
    // Xử lý sự kiện khởi tạo
    on<_Initialized>(_onInitialized);
    // Xử lý sự kiện khi một mục được chọn/bỏ chọn
    on<_CategoryToggled>(_onCategoryToggled);
    // Xử lý sự kiện khi nút "Tất cả" được nhấn
    on<_AllToggled>(_onAllToggled);
  }

  // Phương thức xử lý sự kiện Initialized
  void _onInitialized(
    _Initialized event,
    Emitter<SelectFoodCategoryState> emit,
  ) {
    // Phát ra trạng thái Loaded với dữ liệu ban đầu
    emit(SelectFoodCategoryState.loaded(
      allCategories: event.allCategories,
      allowMultiSelect: event.allowMultiSelect,
      selectedCategories: event.initialSelection,
    ));
  }

  // Phương thức xử lý sự kiện CategoryToggled
  void _onCategoryToggled(
    _CategoryToggled event,
    Emitter<SelectFoodCategoryState> emit,
  ) {
    final currentState = state;
    // Chỉ xử lý nếu trạng thái hiện tại là Loaded
    if (currentState is _Loaded) {
      // Tạo một bản sao có thể thay đổi của các mục đã chọn
      final newSelection = Set<FoodCategory>.from(currentState.selectedCategories);
      final category = event.category;

      if (currentState.allowMultiSelect) {
        // Chế độ chọn nhiều: thêm hoặc xóa mục khỏi Set
        if (newSelection.contains(category)) {
          newSelection.remove(category);
        } else {
          newSelection.add(category);
        }
      } else {
        // Chế độ chọn một:
        // Nếu mục đã được chọn, bỏ chọn nó.
        // Nếu không, bỏ chọn mục cũ và chọn mục mới.
        if (newSelection.contains(category)) {
          newSelection.clear(); // Bỏ chọn
        } else {
          newSelection.clear(); // Bỏ chọn mục cũ
          newSelection.add(category); // Chọn mục mới
        }
      }

      // Phát ra trạng thái mới với các mục đã chọn được cập nhật
      emit(currentState.copyWith(selectedCategories: newSelection));
    }
  }

  // Phương thức xử lý sự kiện AllToggled
  void _onAllToggled(
    _AllToggled event,
    Emitter<SelectFoodCategoryState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded && currentState.allowMultiSelect) {
      final bool isAllSelected = currentState.selectedCategories.length == currentState.allCategories.length;

      Set<FoodCategory> newSelection;
      if (isAllSelected) {
        // Nếu tất cả đang được chọn -> bỏ chọn tất cả
        newSelection = {};
      } else {
        // Nếu không -> chọn tất cả
        newSelection = Set<FoodCategory>.from(currentState.allCategories);
      }

      emit(currentState.copyWith(selectedCategories: newSelection));
    }
  }
}
