import 'package:flutter/material.dart';

/// Enum đại diện cho các hạng mục đánh giá chính.
enum ReviewCategory {
  food('Món ăn', Colors.orange),
  ambiance('Không gian', Colors.teal),
  price('Giá cả', Colors.green),
  service('Phục vụ', Colors.blue);

  final String label;
  final Color color;

  const ReviewCategory(this.label, this.color);

  /// Getter đã được nâng cấp để lấy các ReviewChoice tương ứng với một mức rating cụ thể.
  List<ReviewChoice> availableChoices({required int rating}) {
    if (rating == 0) return [];
    return ReviewChoice.values.where((choice) => choice.category == this && choice.ratingLevel == rating).toList();
  }
}

/// Enum đại diện cho tất cả các lựa chọn đánh giá chi tiết.
/// Mỗi lựa chọn được gắn với một `ReviewCategory` và một `ratingLevel` cụ thể.
/// Các lựa chọn được thiết kế để có thể kết hợp với nhau một cách logic.
enum ReviewChoice {
  // =============================================================
  // === 🍽️ LỰA CHỌN CHO MÓN ĂN (FOOD) ===
  // =============================================================
  // --- 1 SAO: Rất tệ ---
  foodNotFresh(ReviewCategory.food, 1, '🤢 Nguyên liệu không tươi'),
  foodServedCold(ReviewCategory.food, 1, '🧊 Món ăn bị nguội'),
  foodUnsanitary(ReviewCategory.food, 1, '☣️ Có vấn đề vệ sinh'),
  foodBadSmell(ReviewCategory.food, 1, '👃 Mùi vị lạ/khó chịu'),
  foodInedible(ReviewCategory.food, 1, '🚫 Không thể ăn được'),

  // --- 2 SAO: Kém ---
  foodBland(ReviewCategory.food, 2, '😐 Nhạt nhẽo'),
  foodSalty(ReviewCategory.food, 2, '🧂 Quá mặn / ngọt / chua'),
  foodOily(ReviewCategory.food, 2, '🧈 Nhiều dầu mỡ'),
  foodSmallPortion(ReviewCategory.food, 2, '🤏 Phần ăn ít'),
  foodPoorQuality(ReviewCategory.food, 2, '👎 Chất lượng kém'),

  // --- 3 SAO: Trung bình ---
  foodAverage(ReviewCategory.food, 3, '🤔 Hương vị bình thường'),
  foodNotHotEnough(ReviewCategory.food, 3, '🌡️ Không đủ nóng'),
  foodPresentationOkay(ReviewCategory.food, 3, '👀 Trình bày tạm được'),
  foodAbitDry(ReviewCategory.food, 3, '🌵 Hơi khô / cứng'),
  foodStandard(ReviewCategory.food, 3, '📝 Đúng như mong đợi'),

  // --- 4 SAO: Tốt ---
  foodFlavorful(ReviewCategory.food, 4, '😋 Đậm đà, hợp vị'),
  foodGoodPortion(ReviewCategory.food, 4, '🍽️ Phần ăn đầy đặn'),
  foodWellCooked(ReviewCategory.food, 4, '🍳 Chế biến tốt'),
  foodGoodTexture(ReviewCategory.food, 4, '🍮 Kết cấu/Độ mềm tốt'),
  foodAromatic(ReviewCategory.food, 4, '👃 Thơm, hấp dẫn'),

  // --- 5 SAO: Rất tốt ---
  foodFreshIngredients(ReviewCategory.food, 5, '🌿 Nguyên liệu tươi ngon'),
  foodBeautifulPresentation(ReviewCategory.food, 5, '🎨 Trình bày đẹp mắt'),
  foodUnique(ReviewCategory.food, 5, '✨ Sáng tạo, độc đáo'),
  foodExcellentFlavor(ReviewCategory.food, 5, '😍 Vị ngon xuất sắc'),
  foodMemorable(ReviewCategory.food, 5, '💖 Trải nghiệm đáng nhớ'),

  // =============================================================
  // === 🖼️ LỰA CHỌN CHO KHÔNG GIAN (AMBIANCE) ===
  // =============================================================
  // --- 1 SAO: Rất tệ ---
  ambianceNotClean(ReviewCategory.ambiance, 1, '🧽 Bẩn, không vệ sinh'),
  ambianceBadSmell(ReviewCategory.ambiance, 1, '👃 Có mùi khó chịu'),
  ambiancePestProblem(ReviewCategory.ambiance, 1, '🐜 Có côn trùng'),
  ambianceUnsafe(ReviewCategory.ambiance, 1, '🔒 Cảm giác không an toàn'),
  ambiancePoorMaintenance(ReviewCategory.ambiance, 1, '🏚️ Cơ sở vật chất cũ, hỏng'),

  // --- 2 SAO: Kém ---
  ambianceCramped(ReviewCategory.ambiance, 2, '😰 Chật chội, bí bách'),
  ambianceNoisy(ReviewCategory.ambiance, 2, '🔊 Ồn ào, khó nói chuyện'),
  ambianceHot(ReviewCategory.ambiance, 2, '🔥 Nóng, không có điều hoà'),
  ambianceHardToPark(ReviewCategory.ambiance, 2, '🚫 Khó tìm/để xe'),
  ambiancePoorLighting(ReviewCategory.ambiance, 2, '💡 Ánh sáng kém'),

  // --- 3 SAO: Trung bình ---
  ambianceStandard(ReviewCategory.ambiance, 3, '🤔 Không gian bình thường'),
  ambianceBitNoisy(ReviewCategory.ambiance, 3, '🗣️ Hơi ồn'),
  ambianceSimpleDecor(ReviewCategory.ambiance, 3, '🖼️ Trang trí đơn giản'),
  ambianceLimitedSeating(ReviewCategory.ambiance, 3, '🪑 Hơi ít chỗ ngồi'),
  ambianceOkay(ReviewCategory.ambiance, 3, '😐 Cũng được'),

  // --- 4 SAO: Tốt ---
  ambianceClean(ReviewCategory.ambiance, 4, '🧹 Sạch sẽ, gọn gàng'),
  ambianceCozy(ReviewCategory.ambiance, 4, '🛋️ Ấm cúng, dễ chịu'),
  ambianceGoodMusic(ReviewCategory.ambiance, 4, '🎶 Nhạc hay, phù hợp'),
  ambianceAirConditioned(ReviewCategory.ambiance, 4, '❄️ Mát mẻ'),
  ambianceGoodForAll(ReviewCategory.ambiance, 4, '👨‍👩‍👧‍👦 Phù hợp nhiều đối tượng'),

  // --- 5 SAO: Rất tốt ---
  ambianceBeautifulDecor(ReviewCategory.ambiance, 5, '✨ Decor đẹp, có gu'),
  ambianceGreatView(ReviewCategory.ambiance, 5, '🏙️ View đẹp, ấn tượng'),
  ambiancePrivate(ReviewCategory.ambiance, 5, '🤫 Yên tĩnh, riêng tư'),
  ambianceSpacious(ReviewCategory.ambiance, 5, '🏞️ Rộng rãi, thoáng đãng'),
  ambianceUniqueTheme(ReviewCategory.ambiance, 5, '🎨 Chủ đề độc đáo'),

  // =============================================================
  // === 💰 LỰA CHỌN CHO GIÁ CẢ (PRICE) ===
  // =============================================================
  // --- 1 SAO: Rất tệ ---
  priceOverpriced(ReviewCategory.price, 1, '💸 Quá đắt so với chất lượng'),
  priceHiddenFees(ReviewCategory.price, 1, '⚠️ Có nhiều phụ thu ẩn'),
  priceMenuConfusing(ReviewCategory.price, 1, '❓ Menu giá không rõ ràng'),
  priceNotWorthIt(ReviewCategory.price, 1, '📉 Hoàn toàn không đáng tiền'),
  pricePoorValue(ReviewCategory.price, 1, '💔 Giá trị nhận lại thấp'),

  // --- 2 SAO: Kém ---
  priceExpensive(ReviewCategory.price, 2, '🤔 Giá cao'),
  priceSmallPortionForPrice(ReviewCategory.price, 2, '⚖️ Phần ăn ít so với giá'),
  priceDrinksOverpriced(ReviewCategory.price, 2, '🥤 Đồ uống giá cao'),
  priceLimitedOptions(ReviewCategory.price, 2, '🛒 Ít lựa chọn trong tầm giá'),
  priceNoPromo(ReviewCategory.price, 2, '🏷️ Không có khuyến mãi'),

  // --- 3 SAO: Trung bình ---
  priceAverage(ReviewCategory.price, 3, '😐 Mức giá trung bình'),
  priceSlightlyHigh(ReviewCategory.price, 3, '🤔 Hơi cao một chút'),
  priceAsExpected(ReviewCategory.price, 3, '👍 Giá đúng như mong đợi'),
  priceStandard(ReviewCategory.price, 3, '📊 Theo mặt bằng chung'),
  priceOkay(ReviewCategory.price, 3, '🤷 Cũng được'),

  // --- 4 SAO: Tốt ---
  priceAffordable(ReviewCategory.price, 4, '👌 Giá phải chăng, hợp lý'),
  priceValueForMoney(ReviewCategory.price, 4, '👍 Tương xứng chất lượng'),
  priceClearMenu(ReviewCategory.price, 4, '🧾 Menu giá rõ ràng'),
  priceGoodDeals(ReviewCategory.price, 4, '🤝 Có combo/ưu đãi tốt'),
  priceReasonable(ReviewCategory.price, 4, '😌 Hợp lý'),

  // --- 5 SAO: Rất tốt ---
  priceVeryAffordable(ReviewCategory.price, 5, '🎉 Giá quá rẻ, bất ngờ'),
  priceExcellentValue(ReviewCategory.price, 5, '💖 Giá trị nhận lại vượt trội'),
  priceHasPromotion(ReviewCategory.price, 5, '🎁 Có chương trình khuyến mãi tốt'),
  priceNoServiceCharge(ReviewCategory.price, 5, '💯 Không phụ thu'),
  priceGenerous(ReviewCategory.price, 5, ' generous'),

  // =============================================================
  // === 💁 LỰA CHỌN CHO PHỤC VỤ (SERVICE) ===
  // =============================================================
  // --- 1 SAO: Rất tệ ---
  serviceBadAttitude(ReviewCategory.service, 1, '😠 Thái độ rất tệ'),
  serviceRude(ReviewCategory.service, 1, '🗣️ Thô lỗ, thiếu tôn trọng'),
  serviceIgnored(ReviewCategory.service, 1, '⏳ Bị lơ, gọi không ai trả lời'),
  serviceOrderMistake(ReviewCategory.service, 1, '❌ Lên sai/thiếu nhiều món'),
  serviceUnprofessional(ReviewCategory.service, 1, '🤦 Thiếu chuyên nghiệp'),

  // --- 2 SAO: Kém ---
  serviceSlow(ReviewCategory.service, 2, '🐢 Phục vụ chậm, chờ lâu'),
  serviceIndifferent(ReviewCategory.service, 2, '😐 Nhân viên thờ ơ'),
  serviceHardToBook(ReviewCategory.service, 2, '☎️ Khó liên hệ/đặt bàn'),
  serviceForgetful(ReviewCategory.service, 2, '🤔 Hay quên yêu cầu'),
  serviceNotHelpful(ReviewCategory.service, 2, '🤷 Không hỗ trợ khách'),

  // --- 3 SAO: Trung bình ---
  serviceOkay(ReviewCategory.service, 3, '😐 Phục vụ bình thường'),
  serviceStandard(ReviewCategory.service, 3, '👍 Tạm ổn, không có gì nổi bật'),
  serviceABitSlow(ReviewCategory.service, 3, '🏃 Hơi chậm lúc đông khách'),
  servicePolite(ReviewCategory.service, 3, '🙂 Lịch sự'),
  serviceDoesTheJob(ReviewCategory.service, 3, '📝 Làm đúng việc'),

  // --- 4 SAO: Tốt ---
  serviceEnthusiastic(ReviewCategory.service, 4, '😊 Nhân viên nhiệt tình, thân thiện'),
  serviceAttentive(ReviewCategory.service, 4, '👀 Chu đáo, để ý khách'),
  serviceGoodAdvice(ReviewCategory.service, 4, '💡 Tư vấn món tốt'),
  serviceResponsive(ReviewCategory.service, 4, '🙋‍♂️ Phản hồi nhanh'),
  serviceWelcoming(ReviewCategory.service, 4, '👋 Chào đón niềm nở'),

  // --- 5 SAO: Rất tốt ---
  serviceFast(ReviewCategory.service, 5, '🚀 Lên món cực nhanh'),
  serviceProfessional(ReviewCategory.service, 5, '🤵 Rất chuyên nghiệp'),
  serviceEasyBooking(ReviewCategory.service, 5, '📱 Đặt bàn dễ dàng'),
  serviceAboveAndBeyond(ReviewCategory.service, 5, '💖 Vượt trên cả mong đợi'),
  serviceMemorable(ReviewCategory.service, 5, '🌟 Phục vụ ấn tượng');

  /// Category mà choice này thuộc về.
  final ReviewCategory category;

  /// Mức rating mà choice này sẽ hiển thị.
  final int ratingLevel;

  /// Nhãn hiển thị trên UI.
  final String label;

  const ReviewChoice(this.category, this.ratingLevel, this.label);
}
