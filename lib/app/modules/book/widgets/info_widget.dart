import 'package:audio_youtube/app/core/extension/num_extention.dart';

import 'package:flutter/material.dart';

import '../../../../data_test/data_test.dart';
import '../../../core/values/text_styles.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dataTestInfo['name'] ?? '',
          style: titleStyle.s16,
          textAlign: TextAlign.center,
        ),
        5.h,
        Row(
          children: [
            Text(
              'Tác giả: ',
              style: titleStyle.s14,
            ),
            Text(
              ' ${dataTestInfo['author']}',
              style: titleStyle.s14.copyWith(color: Colors.blue),
            ),
          ],
        ),
        5.h,
        Row(
          children: [
            Text(
              'Trạng thái: ',
              style: titleStyle.s14,
            ),
            Text(
              '${dataTestInfo['status']}',
              style: titleStyle.s14.copyWith(color: Colors.blue),
            ),
          ],
        ),
        5.h,
        Row(
          children: [
            Text(
              'Lượt xem: ',
              style: titleStyle.s14,
            ),
            Text(
              '${dataTestInfo['view']}',
              style: titleStyle.s14.copyWith(color: Colors.blue),
            ),
          ],
        ),
        5.h,
        Text(
          dataTestInfo['category'] ?? '',
          style: titleStyle.s14,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
