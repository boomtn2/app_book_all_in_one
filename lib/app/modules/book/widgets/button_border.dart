import 'package:flutter/widgets.dart';

import '../../../core/values/app_borders.dart';
import '../../../views/border_button.dart';

class ButtonBorder extends StatelessWidget {
  const ButtonBorder({super.key, required this.title, required this.fct});
  final String title;

  final Function fct;
  @override
  Widget build(BuildContext context) {
    return BorderButton(
      title: title,
      fct: fct,
      gradient: AppBorders.greyWhite,
    );
  }
}
