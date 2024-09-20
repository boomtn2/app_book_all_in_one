import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../views/text/text_loadmore.dart';

class TitleView extends StatelessWidget {
  const TitleView(
      {super.key,
      required this.title,
      this.style = bigTitleStyle,
      this.child,
      required this.funtion});
  final String title;
  final TextStyle style;
  final Widget? child;
  final Function funtion;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style,
        ),
        if (child != null) child!,
        InkWell(onTap: () => funtion(), child: const TextLoadmoreView())
      ],
    );
  }
}
