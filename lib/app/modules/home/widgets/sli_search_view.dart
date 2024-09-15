import 'package:flutter/material.dart';

import '../../../core/values/app_values.dart';
import '../../../views/seach_textfield.dart';

class SliSearchView extends StatelessWidget {
  const SliSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.paddingLeft,
          right: AppValues.paddingLeft,
        ),
        child: SearchTextFieldView(),
      ),
    );
  }
}
