class SortOption {
  final SortField field;
  final SortDirection direction;

  const SortOption(this.field, this.direction);

  String get displayName {
    final icon = field.icon;
    final label = field.label;
    final arrow = direction == SortDirection.desc ? '↓' : '↑';
    return '$icon $label $arrow';
  }

  @override
  String toString() => displayName;
}

enum SortField {
  datePosted('📅', 'Ngày đăng'),
  likes('❤️', 'Lượt thích'),
  comments('💬', 'Lượt bình luận'),
  saves('🔖', 'Lượt lưu'),
  location('📍', 'Vị trí');

  final String icon;
  final String label;
  const SortField(this.icon, this.label);
}
enum SortDirection { asc, desc }
