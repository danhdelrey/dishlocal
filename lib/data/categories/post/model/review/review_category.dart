import 'package:dishlocal/data/categories/post/model/review/review_choice.dart';
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
