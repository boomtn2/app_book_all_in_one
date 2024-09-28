import 'package:flutter/material.dart';

import '../../../../core/values/text_styles.dart';

class ButtonAudio extends StatelessWidget {
  const ButtonAudio(
      {super.key,
      required this.icon,
      required this.title,
      required this.callback,
      this.color});
  final IconData icon;
  final String title;
  final GestureTapCallback? callback;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50), // Đảm bảo ripple có viền tròn
      focusColor: Colors.blue,
      hoverColor: Colors.blue,
      highlightColor: Colors.blue,
      overlayColor: const WidgetStatePropertyAll(Colors.black),
      onTap: callback,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              title,
              style: afaca.s10,
            )
          ],
        ),
      ),
    );
  }
}
