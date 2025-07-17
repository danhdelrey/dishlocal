import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_option.freezed.dart';

// THÊM MỚI: Một enum để xác định ngữ cảnh, giúp code dễ đọc hơn.
enum FilterContext {
  explore,
  search,
}

enum SortField {
  relevance('🏆', 'Liên quan nhất'), // <-- THÊM MỚI
  datePosted('📅', 'Ngày đăng'),
  likes('❤️', 'Lượt thích'),
  comments('💬', 'Lượt bình luận'),
  saves('🔖', 'Lượt lưu');

  final String icon;
  final String label;
  const SortField(this.icon, this.label);
}

enum SortDirection { asc, desc }

@freezed
abstract class SortOption with _$SortOption {
  const SortOption._();

  const factory SortOption({
    required SortField field,
    required SortDirection direction,
  }) = _SortOption;

  /// Lựa chọn mặc định cho Explore Screen
  static const SortOption defaultSort = SortOption(
    field: SortField.datePosted,
    direction: SortDirection.desc,
  );

  /// Lựa chọn mặc định cho Search Result Screen
  static const SortOption relevanceSort = SortOption(
    field: SortField.relevance,
    direction: SortDirection.desc, // Direction không quan trọng nhưng phải có
  );

  String get displayName {
    final icon = field.icon;
    final label = field.label;

    // Không hiển thị mũi tên cho "Liên quan nhất"
    if (field == SortField.relevance) {
      return '$icon $label';
    }

    final arrow = direction == SortDirection.desc ? '↓' : '↑';
    return '$icon $label $arrow';
  }
  
  /// THAY ĐỔI QUAN TRỌNG: Chuyển `allOptions` và `uniqueFields` thành phương thức động.

  /// Lấy danh sách tất cả các tùy chọn sắp xếp dựa trên ngữ cảnh.
  static List<SortOption> getAllOptions({
    required FilterContext forContext,
  }) {
    final baseOptions = [
      const SortOption(field: SortField.datePosted, direction: SortDirection.desc),
      const SortOption(field: SortField.datePosted, direction: SortDirection.asc),
      const SortOption(field: SortField.likes, direction: SortDirection.desc),
      const SortOption(field: SortField.likes, direction: SortDirection.asc),
      const SortOption(field: SortField.comments, direction: SortDirection.desc),
      const SortOption(field: SortField.comments, direction: SortDirection.asc),
      const SortOption(field: SortField.saves, direction: SortDirection.desc),
      const SortOption(field: SortField.saves, direction: SortDirection.asc),
    ];

    if (forContext == FilterContext.search) {
      // Nếu là màn hình tìm kiếm, thêm "Liên quan nhất" vào đầu danh sách.
      return [relevanceSort, ...baseOptions];
    }
    
    // Ngược lại, trả về danh sách cơ bản cho Explore.
    return baseOptions;
  }
  
  /// Lấy danh sách các trường sắp xếp duy nhất dựa trên ngữ cảnh.
  static List<SortField> getUniqueFields({
    required FilterContext forContext,
  }) {
    final baseFields = [
      SortField.datePosted,
      SortField.likes,
      SortField.comments,
      SortField.saves,
    ];

    if (forContext == FilterContext.search) {
      // Thêm "Liên quan nhất" vào đầu danh sách cho màn hình tìm kiếm.
      return [SortField.relevance, ...baseFields];
    }

    return baseFields;
  }

  bool get isReversible {
    // Relevance không thể đảo ngược chiều.
    if (field == SortField.relevance) {
      return false;
    }
    return true;
  }
}