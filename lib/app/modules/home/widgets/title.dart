import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  const TitleView({super.key, required this.title, this.style = bigTitleStyle});
  final String title;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: style,
        ),
      ],
    );
  }
}
