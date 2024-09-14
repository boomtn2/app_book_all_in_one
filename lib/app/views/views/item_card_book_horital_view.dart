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
                gradient: LinearGradient(colors: [
                  Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.2),
                  Theme.of(context).colorScheme.primary.withOpacity(0.2)
                ]),
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1)),
            child: InkWell(
              onTap: () {
                if (book != null) openDetail(book!);
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 125,
                  width: 220,
                  child: Row(
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
                                      height: 125,
                                      width: 80,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: CacheImage(
                                      height: 120,
                                      width: 70,
                                      borderRadius: AppBorders.borderCardItem,
                                      url: book?.img,
                                    ),
                                  ),
                                ],
                              )
                            : CacheImage(
                                height: 125,
                                width: 80,
                                borderRadius: AppBorders.borderCardItem,
                                url: book?.img,
                              ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              10.h,
                              Text(
                                  book?.detail ??
                                      book?.snippet?.description ??
                                      ''.toUpperCase(),
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: afaca.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 1)),
                              10.h,
                              Text(
                                  book?.snippet?.channelTitle ??
                                      ''.toUpperCase(),
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: afaca.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 1)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
