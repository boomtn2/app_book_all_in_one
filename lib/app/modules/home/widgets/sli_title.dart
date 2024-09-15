import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_values.dart';
import '../../../views/folder/tabbar_folder.dart';

class SliverTitle extends StatelessWidget {
  const SliverTitle({super.key, required this.tabs});
  final Map<String, bool> tabs;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft, right: AppValues.paddingRight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabbarFolder(
              tabs: tabs,
              fct: (value) {},
            ),
            5.h,
          ],
        ),
      ),
    );
  }
}
