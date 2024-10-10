import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:flutter/material.dart';
import '../../../core/values/text_styles.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.model});
  final BookModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: titleStyle.s16,
          textAlign: TextAlign.center,
        ),
        5.h,
        Row(
          children: [
            Text(
              'Tác giả: ',
              maxLines: 1,
              style: titleStyle.s14,
            ),
            Expanded(
              child: Text(
                ' ${model.author}',
                maxLines: 1,
                style: titleStyle.s14.copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
        5.h,
        Row(
          children: [
            Text(
              'Trạng thái: ',
              maxLines: 1,
              style: titleStyle.s14,
            ),
            Expanded(
              child: Text(
                '${model.status}',
                maxLines: 1,
                style: titleStyle.s14.copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
        5.h,
        Row(
          children: [
            Text(
              'Lượt xem: ',
              maxLines: 1,
              style: titleStyle.s14,
            ),
            Expanded(
              child: Text(
                '${model.view}',
                maxLines: 1,
                style: titleStyle.s14.copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
        5.h,
        Expanded(
          child: Text(
            model.category ?? '',
            style: titleStyle.s14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
