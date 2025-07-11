import 'package:dishlocal/data/categories/post/model/review/review_category.dart';

/// Enum đại diện cho tất cả các lựa chọn đánh giá chi tiết.
/// Mỗi lựa chọn được gắn với một `ReviewCategory` cụ thể để đảm bảo tính logic.
/// Cách đặt tên `category_choiceName` giúp code dễ đọc và tránh trùng lặp.
enum ReviewChoice {
  // --- Lựa chọn cho Món ăn ---
  foodDelicious(ReviewCategory.food, '😍 Quá ngon'),
  foodGood(ReviewCategory.food, '😋 Vừa miệng'),
  foodAverage(ReviewCategory.food, '🙂 Tạm ổn'),
  foodSalty(ReviewCategory.food, '🧂 Hơi mặn'),
  foodBland(ReviewCategory.food, '😐 Hơi nhạt'),
  foodBad(ReviewCategory.food, '🤢 Không ngon'),

  // --- Lựa chọn cho Không gian ---
  ambianceSpacious(ReviewCategory.ambiance, '🏞️ Rộng rãi, thoáng mát'),
  ambianceCozy(ReviewCategory.ambiance, '🛋️ Ấm cúng, riêng tư'),
  ambianceBeautiful(ReviewCategory.ambiance, '✨ Decor đẹp, sang trọng'),
  ambianceCramped(ReviewCategory.ambiance, '😰 Hơi chật'),
  ambianceNoisy(ReviewCategory.ambiance, '🔊 Ồn ào'),

  // --- Lựa chọn cho Giá cả ---
  priceCheap(ReviewCategory.price, '👍 Rẻ, hợp túi tiền'),
  priceReasonable(ReviewCategory.price, '👌 Giá cả hợp lý'),
  priceExpensive(ReviewCategory.price, '💸 Hơi đắt'),
  priceVeryExpensive(ReviewCategory.price, '🤑 Quá đắt'),

  // --- Lựa chọn cho Phục vụ ---
  serviceFast(ReviewCategory.service, '🚀 Nhanh nhẹn'),
  serviceFriendly(ReviewCategory.service, '😊 Thân thiện, nhiệt tình'),
  serviceProfessional(ReviewCategory.service, '🤵 Chuyên nghiệp'),
  serviceSlow(ReviewCategory.service, '🐢 Hơi chậm'),
  serviceBadAttitude(ReviewCategory.service, '😠 Thái độ kém');

  /// Category mà choice này thuộc về.
  final ReviewCategory category;

  /// Nhãn hiển thị trên UI.
  final String label;

  const ReviewChoice(this.category, this.label);
}
