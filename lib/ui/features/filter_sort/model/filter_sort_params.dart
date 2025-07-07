import 'package:dishlocal/ui/features/filter_sort/model/distance_range.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/filter_sort/model/price_range.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_sort_params.freezed.dart';

/// Một class bất biến để chứa tất cả các tham số lọc và sắp xếp.
///
/// Class này được sử dụng để đóng gói trạng thái bộ lọc thành một đối tượng duy nhất,
/// giúp dễ dàng truyền dữ liệu giữa các lớp và ghi log.
@freezed
abstract class FilterSortParams with _$FilterSortParams {
  const factory FilterSortParams({
    /// Các danh mục món ăn đã chọn. Mặc định là một Set rỗng.
    @Default({}) Set<FoodCategory> categories,

    /// Khoảng giá đã chọn. Có thể là null nếu không chọn.
    PriceRange? range,
    DistanceRange? distance,

    /// Tùy chọn sắp xếp. Luôn có giá trị, mặc định là sắp xếp theo ngày đăng mới nhất.
    @Default(SortOption.defaultSort) SortOption sortOption,
  }) = _FilterSortParams;
}
