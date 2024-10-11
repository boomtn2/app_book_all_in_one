import 'package:audio_youtube/app/core/extension/num_extention.dart';

import 'package:audio_youtube/app/views/views/cache_image_view.dart';
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
              height: 170,
              width: 140,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 130,
                      width: 130,
                      child: CacheImage(
                        url: book?.img ?? '',
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(book?.title ?? ''.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: afaca.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      height: 1)),
                            ),
                          ),
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
