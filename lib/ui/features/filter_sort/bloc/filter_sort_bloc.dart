import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/filter_sort/model/price_range.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'filter_sort_event.dart';
part 'filter_sort_state.dart';
part 'filter_sort_bloc.freezed.dart';

@injectable
class FilterSortBloc extends Bloc<FilterSortEvent, FilterSortState> {
  FilterSortBloc() : super(FilterSortState.initial()) {
    on<_Initialized>(_onInitialized);
    on<_CategoryToggled>(_onCategoryToggled);
    on<_AllCategoriesToggled>(_onAllCategoriesToggled);
    on<_PriceRangeToggled>(_onPriceRangeToggled);
    on<_SortOptionSelected>(_onSortOptionSelected);
    on<_FiltersCleared>(_onFiltersCleared);
  }

  void _onInitialized(_Initialized event, Emitter<FilterSortState> emit) {
    emit(FilterSortState.loaded(
      // Danh sách tất cả các lựa chọn
      allCategories: FoodCategory.values,
      allRanges: PriceRange.values,
      allSortOptions: SortOption.allOptions,
      // Lựa chọn ban đầu hoặc mặc định
      selectedCategories: event.initialCategories ?? {},
      selectedRange: event.initialRange,
      selectedSortOption: event.initialSort ?? SortOption.defaultSort,
    ));
  }

  void _onCategoryToggled(_CategoryToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final newSelection = Set<FoodCategory>.from(currentState.selectedCategories);
      if (newSelection.contains(event.category)) {
        newSelection.remove(event.category);
      } else {
        newSelection.add(event.category);
      }
      emit(currentState.copyWith(selectedCategories: newSelection));
    }
  }

  void _onAllCategoriesToggled(_AllCategoriesToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final isAllSelected = currentState.selectedCategories.length == currentState.allCategories.length;
      final newSelection = isAllSelected ? <FoodCategory>{} : Set<FoodCategory>.from(currentState.allCategories);
      emit(currentState.copyWith(selectedCategories: newSelection));
    }
  }

  void _onPriceRangeToggled(_PriceRangeToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      // Nếu nhấn vào mục đang chọn thì bỏ chọn, ngược lại thì chọn mục mới
      final newRange = currentState.selectedRange == event.range ? null : event.range;
      emit(currentState.copyWith(selectedRange: newRange));
    }
  }

  void _onSortOptionSelected(_SortOptionSelected event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      // Sắp xếp luôn có một giá trị được chọn
      emit(currentState.copyWith(selectedSortOption: event.option));
    }
  }

  void _onFiltersCleared(_FiltersCleared event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      emit(currentState.copyWith(
        selectedCategories: {},
        selectedRange: null,
        // Khi xóa bộ lọc, sắp xếp sẽ quay về mặc định
        selectedSortOption: SortOption.defaultSort,
      ));
    }
  }
}
