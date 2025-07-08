import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_option.freezed.dart';

enum SortField {
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
  // Constructor riêng tư để thêm các phương thức/getter tùy chỉnh
  const SortOption._();

  const factory SortOption({
    required SortField field,
    required SortDirection direction,
  }) = _SortOption;

  /// Lựa chọn sắp xếp mặc định: Ngày đăng mới nhất
  static const SortOption defaultSort = SortOption(
    field: SortField.datePosted,
    direction: SortDirection.desc,
  );

  /// Getter để tạo tên hiển thị động
  String get displayName {
    final icon = field.icon;
    final label = field.label;
    final arrow = direction == SortDirection.desc ? '↓' : '↑';
    return '$icon $label $arrow';
  }

  /// Danh sách tất cả các tùy chọn sắp xếp có thể có để hiển thị trên UI
  static final List<SortOption> allOptions = [
    // Ngày đăng
    const SortOption(field: SortField.datePosted, direction: SortDirection.desc), // Mới nhất
    const SortOption(field: SortField.datePosted, direction: SortDirection.asc), // Cũ nhất
    // Lượt thích
    const SortOption(field: SortField.likes, direction: SortDirection.desc),
    const SortOption(field: SortField.likes, direction: SortDirection.asc),
    // Lượt bình luận
    const SortOption(field: SortField.comments, direction: SortDirection.desc),
    const SortOption(field: SortField.comments, direction: SortDirection.asc),
    // Lượt lưu
    const SortOption(field: SortField.saves, direction: SortDirection.desc),
    const SortOption(field: SortField.saves, direction: SortDirection.asc),
  ];

  /// Danh sách các trường sắp xếp duy nhất có thể chọn.
  static final List<SortField> uniqueFields = [
    SortField.datePosted,
    SortField.likes,
    SortField.comments,
    SortField.saves,
  ];

  /// Kiểm tra xem một trường có hỗ trợ cả 2 chiều sắp xếp không.
  bool get isReversible {
    return true; // Ví dụ: Vị trí chỉ có 1 chiều là 'gần nhất'
  }
}
