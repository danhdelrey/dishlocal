import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/model/filter_sort_params.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/filter_sort/model/price_range.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'filter_sort_event.dart';
part 'filter_sort_state.dart';
part 'filter_sort_bloc.freezed.dart';

@injectable
class FilterSortBloc extends Bloc<FilterSortEvent, FilterSortState> {
  final _log = Logger('FilterSortBloc');
  FilterSortBloc() : super(const FilterSortState.initial()) {
    on<_Initialized>(_onInitialized);
    on<_CategoryToggled>(_onCategoryToggled);
    on<_AllCategoriesToggled>(_onAllCategoriesToggled);
    on<_PriceRangeToggled>(_onPriceRangeToggled);
    on<_SortOptionSelected>(_onSortOptionSelected);
    on<_FiltersCleared>(_onFiltersCleared);
    on<_FiltersSubmitted>(_onFiltersSubmitted);
  }

  void _onInitialized(_Initialized event, Emitter<FilterSortState> emit) {
    emit(FilterSortState.loaded(
      allCategories: FoodCategory.values,
      allRanges: PriceRange.values,
      allSortOptions: SortOption.allOptions,
      // Khởi tạo với params từ event hoặc params rỗng
      currentParams: event.initialParams ?? const FilterSortParams(),
    ));
  }

  // Các handler giờ sẽ thao tác trên `currentParams`
  void _onCategoryToggled(_CategoryToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final currentCategories = currentState.currentParams.categories;
      final newSelection = Set<FoodCategory>.from(currentCategories);

      if (newSelection.contains(event.category)) {
        newSelection.remove(event.category);
      } else {
        newSelection.add(event.category);
      }

      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(categories: newSelection),
      ));
    }
  }

  void _onAllCategoriesToggled(_AllCategoriesToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final isAllSelected = currentState.currentParams.categories.length == currentState.allCategories.length;
      final newSelection = isAllSelected ? <FoodCategory>{} : Set<FoodCategory>.from(currentState.allCategories);

      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(categories: newSelection),
      ));
    }
  }

  void _onPriceRangeToggled(_PriceRangeToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final newRange = currentState.currentParams.range == event.range ? null : event.range;

      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(range: newRange),
      ));
    }
  }

  void _onSortOptionSelected(_SortOptionSelected event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(sortOption: event.option),
      ));
    }
  }

  void _onFiltersCleared(_FiltersCleared event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      // Chỉ cần tạo một FilterSortParams rỗng mới
      emit(currentState.copyWith(currentParams: const FilterSortParams()));
    }
  }

  // Handler cho Submit giờ cực kỳ gọn gàng
  void _onFiltersSubmitted(
    _FiltersSubmitted event,
    Emitter<FilterSortState> emit,
  ) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      // Freezed tự động tạo phương thức toString() rất đẹp!
      _log.info('Filters Submitted: ${currentState.currentParams}');
    }
  }
}
