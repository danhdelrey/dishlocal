import 'package:flutter/material.dart';

/// Enum đại diện cho các loại món ăn, mỗi loại có nhãn và màu sắc riêng.
enum FoodCategory {
  // Định nghĩa các thành viên của enum
  vietnameseMain('🍛 Món chính Việt', Colors.orange),
  hotpotBbq('🍖 Lẩu & Nướng', Colors.red),
  fastFood('🍔 Thức ăn nhanh', Colors.amber),
  international('🍕 Món quốc tế', Colors.deepPurple),
  vegetarianHealthy('🥗 Món chay - Healthy', Colors.green),
  dessert('🍰 Tráng miệng', Colors.pink),
  beverage('🧋 Nước uống', Colors.teal),
  other('🍽️ Món khác', Colors.blueGrey);

  // Các thuộc tính của mỗi thành viên
  final String label;
  final Color color;

  // Constructor hằng số
  const FoodCategory(this.label, this.color);
}
