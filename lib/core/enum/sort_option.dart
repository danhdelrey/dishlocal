enum SortOption {
  datePostedDesc('📅 Ngày đăng (Mới → Cũ)'),
  likesDesc('❤️ Lượt thích (Nhiều → Ít)'),
  commentsDesc('💬 Lượt bình luận (Nhiều → Ít)'),
  savesDesc('🔖 Lượt lưu (Nhiều → Ít)'),
  locationNearToFar('📍 Vị trí (Gần → Xa)');

  const SortOption(this.displayName);

  final String displayName;
}