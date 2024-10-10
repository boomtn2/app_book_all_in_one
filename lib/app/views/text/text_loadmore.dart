import 'package:flutter/material.dart';

import '../../core/values/text_styles.dart';

class TextLoadmoreView extends StatelessWidget {
  const TextLoadmoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Xem thêm',
        style: fontStyteLoadMore,
      ),
    );
  }
}
