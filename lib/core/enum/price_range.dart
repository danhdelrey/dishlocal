/// Enum định nghĩa các khoảng giá tiền với các phương thức tiện ích
///
/// Enum này cung cấp các khoảng giá được định nghĩa trước từ dưới 50k đến trên 1M,
/// bao gồm các phương thức để kiểm tra và tìm kiếm khoảng giá phù hợp.
///
/// **Cách sử dụng:**
///
/// ```dart
/// // Kiểm tra giá có nằm trong khoảng không
/// bool isInRange = PriceRange.from50kTo100k.contains(75000); // true
///
/// // Tìm khoảng giá phù hợp với một mức giá
/// PriceRange? range = PriceRange.fromPrice(120000); // PriceRange.from100kTo200k
///
/// // Lấy tên hiển thị của khoảng giá
/// String displayText = PriceRange.under50k.displayName; // "Dưới 50k"
///
/// // Truy cập giá trị min/max
/// double min = PriceRange.from200kTo500k.minPrice; // 200000
/// double max = PriceRange.from200kTo500k.maxPrice; // 500000
///
/// // Duyệt qua tất cả các khoảng giá
/// for (final range in PriceRange.values) {
///   print('${range.displayName}: ${range.minPrice} - ${range.maxPrice}');
/// }
/// ```
///
/// **Các khoảng giá có sẵn:**
/// - `under50k`: Dưới 50,000 VND
/// - `from50kTo100k`: Từ 50,000 đến 100,000 VND
/// - `from100kTo200k`: Từ 100,000 đến 200,000 VND
/// - `from200kTo500k`: Từ 200,000 đến 500,000 VND
/// - `from500kTo1M`: Từ 500,000 đến 1,000,000 VND
/// - `over1M`: Trên 1,000,000 VND
library;

enum PriceRange {
  under50k(0, 50000, 'Dưới 50k'),
  from50kTo100k(50000, 100000, '50k - 100k'),
  from100kTo200k(100000, 200000, '100k - 200k'),
  from200kTo500k(200000, 500000, '200k - 500k'),
  from500kTo1M(500000, 1000000, '500k - 1M'),
  over1M(1000000, double.infinity, 'Trên 1M');

  const PriceRange(this.minPrice, this.maxPrice, this.displayName);

  final double minPrice;
  final double maxPrice;
  final String displayName;

  bool contains(double price) {
    return price >= minPrice && price < maxPrice;
  }

  static PriceRange? fromPrice(double price) {
    for (final range in PriceRange.values) {
      if (range.contains(price)) {
        return range;
      }
    }
    return null;
  }
}
