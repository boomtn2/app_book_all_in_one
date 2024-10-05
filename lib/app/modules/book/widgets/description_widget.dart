import 'package:flutter/widgets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.detail});
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppValues.spaceHeadLine}$detail'
          .replaceAll('.', '.\n${AppValues.spaceHeadLine}'),
      style: textStyle.copyWith(height: 1.5),
      textAlign: TextAlign.start,
    );
  }
}
