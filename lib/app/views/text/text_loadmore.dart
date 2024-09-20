import 'package:flutter/material.dart';

import '../../core/values/text_styles.dart';

class TextLoadmoreView extends StatelessWidget {
  const TextLoadmoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Xem thêm',
      style: fontStyteLoadMore,
    );
  }
}
