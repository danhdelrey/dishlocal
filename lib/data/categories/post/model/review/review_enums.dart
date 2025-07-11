import 'package:flutter/material.dart';

/// Enum đại diện cho các hạng mục đánh giá chính.
/// Mỗi hạng mục có nhãn, emoji, màu sắc và một getter để lấy danh sách
/// các lựa chọn (choices) tương ứng.
enum ReviewCategory {
  food('🍽️ Món ăn', Colors.orange),
  ambiance('🖼️ Không gian', Colors.teal),
  price('💰 Giá cả', Colors.green),
  service('💁 Phục vụ', Colors.blue);

  final String label;
  final Color color;

  const ReviewCategory(this.label, this.color);

  /// Getter tiện ích để lấy tất cả các `ReviewChoice` thuộc về hạng mục này.
  /// Đây là mấu chốt giúp thiết kế dễ mở rộng và an toàn.
  List<ReviewChoice> get availableChoices {
    // Lọc từ danh sách tất cả các choice, lấy những choice có category trùng với chính nó.
    return ReviewChoice.values.where((choice) => choice.category == this).toList();
  }
}

/// Enum đại diện cho tất cả các lựa chọn đánh giá chi tiết.
/// Mỗi lựa chọn được gắn với một `ReviewCategory` cụ thể để đảm bảo tính logic.
enum ReviewChoice {
  // =============================================================
  // === 🍽️ LỰA CHỌN CHO MÓN ĂN (FOOD) ===
  // =============================================================
  // --- Đặc điểm tích cực ---
  foodFlavorful(ReviewCategory.food, '😋 Đậm đà, hợp khẩu vị'),
  foodFreshIngredients(ReviewCategory.food, '🌿 Nguyên liệu tươi ngon'),
  foodBeautifulPresentation(ReviewCategory.food, '🎨 Trình bày đẹp mắt'),
  foodGenerousPortion(ReviewCategory.food, '🍽️ Phần ăn đầy đặn'),
  foodUnique(ReviewCategory.food, '✨ Sáng tạo, độc đáo'),

  // --- Đặc điểm cần cải thiện ---
  foodBland(ReviewCategory.food, '😐 Hơi nhạt'),
  foodSalty(ReviewCategory.food, '🧂 Hơi mặn'),
  foodOily(ReviewCategory.food, '🧈 Nhiều dầu mỡ'),
  foodTooSpicy(ReviewCategory.food, '🌶️ Quá cay'),
  foodTooSweet(ReviewCategory.food, '🍬 Ngọt gắt'),
  foodSmallPortion(ReviewCategory.food, '🤏 Phần ăn hơi ít'),
  foodNotFresh(ReviewCategory.food, '🤢 Nguyên liệu không tươi'),
  foodServedCold(ReviewCategory.food, '🧊 Món ăn bị nguội'),

  // =============================================================
  // === 🖼️ LỰA CHỌN CHO KHÔNG GIAN (AMBIANCE) ===
  // =============================================================
  // --- Đặc điểm tích cực ---
  ambianceSpacious(ReviewCategory.ambiance, '🏞️ Rộng rãi, thoáng đãng'),
  ambianceClean(ReviewCategory.ambiance, '🧹 Sạch sẽ, gọn gàng'),
  ambianceBeautifulDecor(ReviewCategory.ambiance, '✨ Decor đẹp, có gu'),
  ambianceGreatView(ReviewCategory.ambiance, '🏙️ View đẹp'),
  ambianceCozy(ReviewCategory.ambiance, '🛋️ Ấm cúng'),
  ambiancePrivate(ReviewCategory.ambiance, '🤫 Yên tĩnh, riêng tư'),
  ambianceGoodMusic(ReviewCategory.ambiance, '🎶 Nhạc hay'),
  ambianceEasyParking(ReviewCategory.ambiance, '🅿️ Để xe thuận tiện'),
  ambianceAirConditioned(ReviewCategory.ambiance, '❄️ Mát mẻ, có điều hoà'),

  // --- Đặc điểm cần cải thiện ---
  ambianceCramped(ReviewCategory.ambiance, '😰 Chật chội, bí bách'),
  ambianceNoisy(ReviewCategory.ambiance, '🔊 Ồn ào'),
  ambianceNotClean(ReviewCategory.ambiance, '🧽 Chưa sạch sẽ'),
  ambianceHot(ReviewCategory.ambiance, '🔥 Nóng, hầm'),
  ambianceHardToPark(ReviewCategory.ambiance, '🚫 Khó để xe'),
  ambianceBadSmell(ReviewCategory.ambiance, '👃 Có mùi khó chịu'),

  // =============================================================
  // === 💰 LỰA CHỌN CHO GIÁ CẢ (PRICE) ===
  // =============================================================
  // Các lựa chọn này mô tả về giá trị, có thể kết hợp với nhau.
  priceValueForMoney(ReviewCategory.price, '👍 Tương xứng chất lượng'),
  priceAffordable(ReviewCategory.price, '👌 Giá phải chăng'),
  priceSlightlyHigh(ReviewCategory.price, '🤔 Giá hơi cao'),
  priceExpensive(ReviewCategory.price, '💸 Giá đắt'),
  priceHasPromotion(ReviewCategory.price, '🎉 Có chương trình khuyến mãi'),
  priceHiddenFees(ReviewCategory.price, '⚠️ Có phụ thu (VAT, phí phục vụ...)'),
  priceClearMenu(ReviewCategory.price, '🧾 Menu giá rõ ràng'),

  // =============================================================
  // === 💁 LỰA CHỌN CHO PHỤC VỤ (SERVICE) ===
  // =============================================================
  // --- Đặc điểm tích cực ---
  serviceEnthusiastic(ReviewCategory.service, '😊 Nhân viên nhiệt tình, thân thiện'),
  serviceFast(ReviewCategory.service, '🚀 Lên món nhanh'),
  serviceAttentive(ReviewCategory.service, '👀 Chu đáo, quan tâm khách'),
  serviceProfessional(ReviewCategory.service, '🤵 Chuyên nghiệp, am hiểu menu'),
  serviceEasyBooking(ReviewCategory.service, '📱 Đặt bàn dễ dàng'),

  // --- Đặc điểm cần cải thiện ---
  serviceSlow(ReviewCategory.service, '🐢 Phục vụ chậm, chờ lâu'),
  serviceIndifferent(ReviewCategory.service, '😐 Nhân viên lơ là, khó gọi'),
  serviceBadAttitude(ReviewCategory.service, '😠 Thái độ không tốt'),
  serviceOrderMistake(ReviewCategory.service, '❌ Lên sai/thiếu món'),
  serviceHardToBook(ReviewCategory.service, '☎️ Khó liên hệ/đặt bàn');

  /// Category mà choice này thuộc về.
  final ReviewCategory category;

  /// Nhãn hiển thị trên UI.
  final String label;

  const ReviewChoice(this.category, this.label);
}
