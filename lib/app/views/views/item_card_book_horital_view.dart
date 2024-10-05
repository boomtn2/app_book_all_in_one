import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/views/avatar_audio.dart';
import 'package:flutter/material.dart';
import '../../core/values/text_styles.dart';
import '../../data/model/book_model.dart';

class ItemCardBookHoritalView extends StatelessWidget {
  const ItemCardBookHoritalView(
      {super.key, this.book, required this.openDetail});
  final BookModel? book;
  final Function(BookModel) openDetail;

  @override
  Widget build(BuildContext context) {
    return book == null
        ? const SizedBox(
            height: 150,
            width: 120,
          )
        : InkWell(
            onTap: () {
              if (book != null) openDetail(book!);
            },
            child: SizedBox(
              height: 180,
              width: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 130,
                      width: 130,
                      child: AvatarAudio(
                        url: book?.img ?? '',
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          5.h,
                          Text(book?.title ?? ''.toUpperCase(),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: afaca.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  height: 1)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
