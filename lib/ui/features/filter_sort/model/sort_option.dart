
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_option.freezed.dart';

enum SortField {
  datePosted('📅', 'Ngày đăng'),
  likes('❤️', 'Lượt thích'),
  comments('💬', 'Lượt bình luận'),
  saves('🔖', 'Lượt lưu'),
  location('📍', 'Gần nhất'); // Đổi thành "Gần nhất" cho rõ nghĩa

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
    // Chỉ hiển thị mũi tên cho các trường có thứ tự rõ ràng
    if (field == SortField.location) {
      return '$icon $label';
    }
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
    // Vị trí (chỉ có 1 hướng: gần nhất)
    const SortOption(field: SortField.location, direction: SortDirection.asc),
  ];
}
