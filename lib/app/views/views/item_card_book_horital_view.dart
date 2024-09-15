import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';

import 'package:flutter/material.dart';

import '../../core/values/app_borders.dart';
import '../../core/values/text_styles.dart';
import '../../data/model/book_model.dart';
import 'cache_image_view.dart';

class ItemCardBookHoritalView extends StatelessWidget {
  const ItemCardBookHoritalView(
      {super.key, this.book, required this.openDetail});
  final BookModel? book;
  final Function(BookModel) openDetail;
  @override
  Widget build(BuildContext context) {
    return book == null
        ? const Expanded(
            child: SizedBox(
            height: 5,
            width: 5,
          ))
        : Container(
            decoration: BoxDecoration(
                borderRadius: AppBorders.borderCardItem,
                color: Colors.black,
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1)),
            child: InkWell(
              onTap: () {
                if (book != null) openDetail(book!);
              },
              child: SizedBox(
                height: 150,
                width: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (book?.img != null)
                      book!.type.contains(Const.typePlayList)
                          ? Stack(
                              children: [
                                const Card(
                                  color: Colors.grey,
                                  child: SizedBox(
                                    height: 180,
                                    width: 320,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: CacheImage(
                                    height: 100,
                                    width: 120,
                                    borderRadius: AppBorders.borderCardItem,
                                    url: book?.img,
                                  ),
                                ),
                              ],
                            )
                          : CacheImage(
                              height: 100,
                              width: 120,
                              borderRadius: AppBorders.borderCardItem,
                              url: book?.img,
                            ),
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
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: afaca.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
