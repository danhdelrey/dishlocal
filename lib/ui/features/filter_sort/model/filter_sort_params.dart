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
  const FilterSortParams._(); 
  const factory FilterSortParams({
    @Default({}) Set<FoodCategory> categories,

    /// Khoảng giá đã chọn. Có thể là null nếu không chọn.
    PriceRange? range,
    DistanceRange? distance,

    /// Tùy chọn sắp xếp. Luôn có giá trị, mặc định là sắp xếp theo ngày đăng mới nhất.
    @Default(SortOption.defaultSort) SortOption sortOption,
  }) = _FilterSortParams;

  String get toVietnameseString {
    // Sử dụng StringBuffer để xây dựng chuỗi hiệu quả
    final buffer = StringBuffer();
    buffer.writeln('\n--- 📝 BỘ LỌC & SẮP XẾP ---');

    // 1. Danh mục
    if (categories.isEmpty) {
      buffer.writeln('  - 📋 Loại món: Tất cả');
    } else {
      // Lấy tên của từng danh mục và nối chúng lại
      final categoryLabels = categories.map((e) => e.label).join(', ');
      buffer.writeln('  - 📋 Loại món: $categoryLabels');
    }

    // 2. Mức giá
    if (range == null) {
      buffer.writeln('  - 💰 Mức giá: Không giới hạn');
    } else {
      buffer.writeln('  - 💰 Mức giá: ${range!.displayName}');
    }

    // 3. Khoảng cách
    if (distance == null) {
      buffer.writeln('  - 📍 Khoảng cách: Không giới hạn');
    } else {
      buffer.writeln('  - 📍 Khoảng cách: ${distance!.displayName}');
    }

    // 4. Sắp xếp
    buffer.writeln('  - 📊 Sắp xếp: ${sortOption.displayName}');

    buffer.write('---------------------------');
    return buffer.toString();
  }
}
