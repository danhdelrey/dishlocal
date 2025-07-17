import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/distance_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/price_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
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
    on<_PriceRangeToggled>(_onPriceRangeToggled);
    on<_SortOptionSelected>(_onSortOptionSelected);
    on<_SortDirectionToggled>(_onSortDirectionToggled);
    on<_FiltersCleared>(_onFiltersCleared);
    on<_FiltersSubmitted>(_onFiltersSubmitted);
    on<_DistanceRangeToggled>(_onDistanceRangeToggled);
  }

  void _onInitialized(_Initialized event, Emitter<FilterSortState> emit) {
    // Lấy ngữ cảnh từ initialParams, nếu không có thì mặc định là explore
    final context = event.initialParams?.context ?? FilterContext.explore;

    emit(FilterSortState.loaded(
      allCategories: FoodCategory.values,
      allRanges: PriceRange.values,
      // Sử dụng phương thức động để lấy đúng danh sách tùy chọn
      allSortOptions: SortOption.getAllOptions(forContext: context),
      allDistances: DistanceRange.values,
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


  void _onPriceRangeToggled(_PriceRangeToggled event, Emitter<FilterSortState> emit) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final newRange = currentState.currentParams.range == event.range ? null : event.range;

      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(range: newRange),
      ));
    }
  }

  void _onSortOptionSelected(
    _SortOptionSelected event,
    Emitter<FilterSortState> emit,
  ) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;

      // 1. Lấy ngữ cảnh hiện tại từ `currentParams` của state.
      final context = currentState.currentParams.context;

      // 2. Lấy danh sách các tùy chọn sắp xếp hợp lệ cho ngữ cảnh đó.
      final validOptions = SortOption.getAllOptions(forContext: context);

      // 3. Tìm tùy chọn đầu tiên trong danh sách hợp lệ có `field` khớp.
      // Điều này đảm bảo khi người dùng nhấn vào "Ngày đăng", nó sẽ tự động
      // chọn "Ngày đăng ↓" (giảm dần) làm mặc định.
      final newOption = validOptions.firstWhere(
        (opt) => opt.field == event.option.field,
        orElse: () => event.option, // Dự phòng nếu không tìm thấy
      );

      // 4. Cập nhật state với tùy chọn mới.
      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(sortOption: newOption),
      ));
    }
  }
  void _onSortDirectionToggled(
    _SortDirectionToggled event,
    Emitter<FilterSortState> emit,
  ) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final currentOption = currentState.currentParams.sortOption;

      // Chỉ đảo chiều nếu trường đó hỗ trợ
      if (currentOption.isReversible) {
        final newDirection = currentOption.direction == SortDirection.desc ? SortDirection.asc : SortDirection.desc;

        emit(currentState.copyWith(
          currentParams: currentState.currentParams.copyWith(
            sortOption: currentOption.copyWith(direction: newDirection),
          ),
        ));
      }
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
      _log.info(currentState.currentParams.toVietnameseString);
    }
  }

  void _onDistanceRangeToggled(
    _DistanceRangeToggled event,
    Emitter<FilterSortState> emit,
  ) {
    if (state is FilterSortLoaded) {
      final currentState = state as FilterSortLoaded;
      final newDistance = currentState.currentParams.distance == event.distance ? null : event.distance;

      emit(currentState.copyWith(
        currentParams: currentState.currentParams.copyWith(distance: newDistance),
      ));
    }
  }
}
