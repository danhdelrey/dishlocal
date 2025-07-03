// search_service.dart

import 'package:dishlocal/data/services/search_service/model/search_result.dart';

/// Enum để xác định loại nội dung cần tìm kiếm.
/// Giúp code dễ đọc và an toàn hơn so với việc dùng chuỗi ('posts', 'profiles').
enum SearchableItem {
  posts,
  profiles,
}

/// Định nghĩa các phương thức cần có cho một dịch vụ tìm kiếm.
/// Bất kỳ lớp nào implement `SearchService` sẽ phải cung cấp logic
/// cho các phương thức này.
abstract class SearchService {
  /// Thực hiện tìm kiếm trên Algolia.
  ///
  /// Trả về một `Map` chứa danh sách kết quả và thông tin phân trang.
  ///
  /// - [query]: Chuỗi ký tự người dùng nhập vào để tìm kiếm.
  /// - [searchType]: Loại nội dung cần tìm (`posts` hoặc `profiles`).
  /// - [page]: Trang kết quả muốn lấy (mặc định là 0, trang đầu tiên).
  /// - [hitsPerPage]: Số lượng kết quả trên mỗi trang (mặc định là 20).
  Future<SearchResult> search({
    required String query,
    required SearchableItem searchType,
    int page = 0,
    int hitsPerPage = 20,
  });

  // Trong tương lai, bạn có thể dễ dàng thêm các phương thức khác ở đây
  // ví dụ như tìm kiếm theo vị trí mà không ảnh hưởng đến code hiện tại.
  /*
  Future<Map<String, dynamic>> searchByLocation({
    required String query,
    required SearchableItem searchType,
    required double latitude,
    required double longitude,
    int radiusInMeters = 5000, // bán kính 5km
    int page = 0,
    int hitsPerPage = 20,
  });
  */
}
