import 'package:flutter/material.dart';

/// Enum đại diện cho các loại món ăn, mỗi loại có nhãn và màu sắc riêng.
/// Được sắp xếp theo nhóm để dễ quản lý và mở rộng.
enum FoodCategory {
  // === MÓN VIỆT NAM ===
  vietnameseMain('🍛 Cơm & Món chính Việt', Colors.orange),
  vietnameseNoodles('🍜 Phở, Bún, Mì Việt', Color(0xFFC67C4E)), // Màu nâu của nước dùng
  vietnameseStreetFood('🍢 Ăn vặt & Vỉa hè', Colors.deepOrangeAccent),
  hotpotBbq('🔥 Lẩu & Nướng', Colors.red),

  // === HẢI SẢN ===
  seafood('🦞 Hải sản', Colors.cyan),

  // === MÓN Á ===
  japanese('🍣 Món Nhật', Colors.pinkAccent),
  korean('🥘 Món Hàn', Color(0xFFD93A2B)), // Màu đỏ đặc trưng của Gochujang
  chinese('🥟 Món Trung', Colors.deepPurpleAccent),
  thai('🌶️ Món Thái', Colors.lime),

  // === MÓN ÂU & QUỐC TẾ ===
  fastFood('🍔 Thức ăn nhanh', Colors.amber),
  pizzaAndPasta('🍕 Pizza & Mì Ý', Color(0xFF2E7D32)), // Màu xanh lá của Ý
  internationalOther('🌍 Món Âu & Món khác', Colors.indigoAccent),

  // === LOẠI HÌNH ĐẶC BIỆT ===
  vegetarianHealthy('🥗 Món chay & Healthy', Colors.lightGreen),
  breakfast('🍳 Món sáng', Colors.yellow),
  desserts('🍨 Tráng miệng & Kem', Colors.purpleAccent),
  bakery('🥐 Tiệm bánh', Color(0xFFBCAAA4)), // Màu bánh nướng
  coffeeAndTea('☕ Cà phê & Trà sữa', Colors.brown),
  beverages('🥤 Nước uống & Giải khát', Colors.blue),
  barAndPub('🍻 Bar & Pub', Colors.indigo),

  // === KHÁC ===
  other('🍽️ Danh mục khác', Colors.blueGrey);

  // Các thuộc tính của mỗi thành viên
  final String label;
  final Color color;

  // Constructor hằng số
  const FoodCategory(this.label, this.color);
}
