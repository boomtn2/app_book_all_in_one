import 'package:flutter/widgets.dart';

import '../../../core/values/app_borders.dart';
import '../../../views/border_button.dart';

class ButtonBorder extends StatelessWidget {
  const ButtonBorder(
      {super.key, required this.title, required this.fct, this.icon});
  final String title;
  final IconData? icon;
  final Function fct;
  @override
  Widget build(BuildContext context) {
    return BorderButton(
      title: title,
      fct: fct,
      icon: icon,
      gradient: AppBorders.greyWhite,
    );
  }
}
