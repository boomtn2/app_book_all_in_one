import 'package:flutter/material.dart';

class AppBorders {
  static final BorderRadius borderCardItem = BorderRadius.circular(6);
  static final Gradient greyWhite = LinearGradient(
    begin: Alignment.topLeft, // Hoặc Alignment.centerLeft cho sọc dọc
    end: Alignment.bottomRight, // Hoặc Alignment.centerRight cho sọc dọc
    colors: [
      Colors.grey[300]!, // Màu xám nhạt
      Colors.grey[300]!,
      Colors.white,
      Colors.white,
    ],
    stops: const [0.0, 0.45, 0.55, 1.0], // Điều chỉnh độ rộng của các sọc
  );
  static const Gradient browTree = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF966F33), // Màu nâu đậm
      Color(0xFFB58863), // Màu nâu nhạt hơn
      Color(0xFFF5DEB3), // Màu be nhạt
      Color(0xFFD2B48C), // Màu nâu nhạt
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );
}
