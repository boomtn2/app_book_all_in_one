import 'package:audio_youtube/app/core/extension/num_extention.dart';

import 'package:flutter/material.dart';

import '../../core/values/app_borders.dart';
import '../../core/values/text_styles.dart';
import '../../data/model/book_model.dart';
import 'cache_image_view.dart';

class ItemCardBookView extends StatelessWidget {
  const ItemCardBookView({super.key, this.book});
  final BookModel? book;
  @override
  Widget build(BuildContext context) {
    return book == null
        ? const SizedBox(
            height: 180,
            width: 100,
          )
        : SizedBox(
            height: 180,
            width: 100,
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (book?.img != null)
                    CacheImage(
                      height: 130,
                      width: 90,
                      borderRadius: AppBorders.borderCardItem,
                      url: book?.img,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(book?.author ?? ''.toUpperCase(),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: afaca.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                  ),
                  3.h,
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(book?.title ?? ''.toUpperCase(),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: afaca.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            height: 1)),
                  )
                ],
              ),
            ),
          );
  }
}
