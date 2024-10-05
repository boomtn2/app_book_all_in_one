import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';
import '../../../data/model/book_model.dart';
import '../../../views/views/item_card_book_view.dart';
import '../controllers/home_controller.dart';

class IntroView extends StatelessWidget {
  IntroView({super.key});
  final controller = Get.find<HomeController>();
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
            Obx(() => _body(
                MediaQuery.sizeOf(context),
                controller.dtruyenListBook,
                controller.count(6, controller.dtruyenListBook.length),
                context)),
          ],
        ),
      ),
    );
  }

  Widget _body(
      Size size, List<BookModel> books, int lenght, BuildContext context) {
    return SizedBox(
      height: 360,
      width: size.width - 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < lenght; i++)
            Column(
              children: [
                SizedBox(
                  height: 180,
                  width: size.width - 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex(i * 6),
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex((i * 6) + 1),
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex((i * 6) + 2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  width: size.width - 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex(i * 6 + 3),
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex((i * 6) + 4),
                        ),
                      ),
                      10.w,
                      Expanded(
                        child: ItemCardBookView(
                          callback: (book) {
                            controller.openDtruyen(book, context);
                          },
                          book: books.getNullIndex((i * 6) + 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
