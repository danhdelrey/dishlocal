
enum SearchIndex { posts, profiles }

abstract interface class SearchService {
  /// Tìm kiếm trên một index cụ thể dựa trên một truy vấn.
  ///
  /// [T]: Kiểu dữ liệu của kết quả trả về (ví dụ: `Post`, `Profile`).
  /// [query]: Chuỗi văn bản để tìm kiếm.
  /// [index]: Enum chỉ định index cần tìm kiếm (`SearchIndex.posts` hoặc `SearchIndex.profiles`).
  /// [fromJson]: Một hàm để chuyển đổi một map JSON thành đối tượng kiểu `T`.
  /// [page]: Số trang kết quả, bắt đầu từ 0.
  /// [hitsPerPage]: Số lượng kết quả trên mỗi trang.
  ///
  /// Trả về một `Future<List<T>>`.
  ///
  /// Có thể throw các exception tương tự như các phương thức riêng lẻ.
  Future<List<T>> search<T>({
    required String query,
    required SearchIndex index,
    required T Function(Map<String, dynamic> json) fromJson,
    int page = 0,
    int hitsPerPage = 20,
  });
}
