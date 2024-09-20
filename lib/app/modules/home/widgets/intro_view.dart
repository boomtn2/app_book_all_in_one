import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.paddingLeft,
          right: AppValues.paddingLeft,
        ),
        child: Column(
          children: [
            TitleView(
              title: 'Giới thiệu',
              style: bigTitleStyle.s20,
              funtion: () {},
            ),
          ],
        ),
      ),
    );
  }
}
