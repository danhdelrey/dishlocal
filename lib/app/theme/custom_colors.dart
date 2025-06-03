
import 'package:flutter/material.dart';

const primaryGradient = LinearGradient(
  // Danh sách các màu trong gradient, theo thứ tự từ trái sang phải
  colors: [
    Color(0xFFE39297), // Màu đầu tiên: E39297 (Hồng đào)
    Color(0xFFC779D0), // Màu thứ hai: C779D0 (Tím)
    Color(0xFF899CCC), // Màu thứ ba: 899CCC (Xanh tím)
  ],
  // Các điểm dừng tương ứng với từng màu (từ 0.0 đến 1.0)
  // 0.0 tương ứng với 0%, 0.5 với 50%, 1.0 với 100%
  stops: [
    0.0, // Màu E39297 bắt đầu từ 0%
    0.5, // Màu C779D0 nằm ở 50%
    1.0, // Màu 899CCC kết thúc ở 100%
  ],
  // Điểm bắt đầu của gradient (trái giữa)
  begin: Alignment.centerLeft,
  // Điểm kết thúc của gradient (phải giữa)
  end: Alignment.centerRight,
);
