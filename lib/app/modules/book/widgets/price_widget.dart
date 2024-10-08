import 'package:flutter/material.dart';

import '../../../core/values/app_borders.dart';
import '../../../core/values/text_styles.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: AppBorders.borderCardItem,
          gradient: AppBorders.browTree,
          border: const Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          )),
      child: Center(
        child: Text(
          'Giá: 350.000VND',
          style: headerStyle.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
