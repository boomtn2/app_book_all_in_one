import 'package:flutter/material.dart';

import '../core/values/app_borders.dart';
import '../core/values/text_styles.dart';

class BorderButton extends StatelessWidget {
  const BorderButton(
      {super.key,
      required this.title,
      required this.fct,
      this.gradient,
      this.color = Colors.black,
      this.icon});
  final String title;
  final Function fct;
  final Gradient? gradient;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fct(),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: AppBorders.borderCardItem,
          border: Border(
            bottom: BorderSide(
              color: color,
              width: 2,
            ),
            left: BorderSide(
              color: color,
              width: 2,
            ),
            right: BorderSide(
              color: color,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            icon != null ? Icon(icon) : const SizedBox.shrink(),
            Text(
              title,
              style: headerStyle.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
