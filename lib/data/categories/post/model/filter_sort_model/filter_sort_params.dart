import 'package:dishlocal/data/categories/post/model/filter_sort_model/distance_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/price_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_sort_params.freezed.dart';

/// Một class bất biến để chứa tất cả các tham số lọc, sắp xếp và phân trang.
///
/// Class này được sử dụng để đóng gói trạng thái bộ lọc thành một đối tượng duy nhất,
/// giúp dễ dàng truyền dữ liệu giữa các lớp và ghi log.
@freezed
abstract class FilterSortParams with _$FilterSortParams {
  const FilterSortParams._();
  const factory FilterSortParams({
    // --- Lọc (Filtering) ---
    @Default({}) Set<FoodCategory> categories,
    PriceRange? range,
    DistanceRange? distance,

    // --- Sắp xếp (Sorting) ---
    @Default(SortOption.defaultSort) SortOption sortOption,

    // --- Phân trang (Pagination) ---
    @Default(10) int limit,

    /// Con trỏ của mục cuối cùng trong trang trước.
    /// Kiểu `dynamic` vì nó phụ thuộc vào trường sắp xếp
    /// (ví dụ: `DateTime` cho ngày đăng, `int` cho lượt thích).
    /// Là `null` nếu đây là yêu cầu cho trang đầu tiên.
    dynamic lastCursor,

    /// Con trỏ phụ, chỉ dùng khi sắp xếp theo trường số (likes, comments, etc.)
    /// để phá vỡ thế hòa (tie-breaking).
    DateTime? lastDateCursorForTieBreak,
  }) = _FilterSortParams;

  /// Tạo một bộ lọc mặc định.
  factory FilterSortParams.defaultParams() => const FilterSortParams();

  String get toVietnameseString {
    // ... (phần này giữ nguyên, bạn có thể thêm limit và cursor nếu muốn) ...
    final buffer = StringBuffer();
    buffer.writeln('\n--- 📝 BỘ LỌC & SẮP XẾP ---');

    // 1. Danh mục
    if (categories.isEmpty) {
      buffer.writeln('  - 📋 Loại món: Tất cả');
    } else {
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

    // 5. Phân trang
    buffer.writeln('  - 📑 Giới hạn: $limit mục/trang');
    buffer.writeln('  - 👉 Con trỏ trang: ${lastCursor ?? "Trang đầu"}');

    buffer.write('---------------------------');
    return buffer.toString();
  }
  bool isDefault() {
    // So sánh với một instance mặc định
    return this == FilterSortParams.defaultParams();
  }
}
