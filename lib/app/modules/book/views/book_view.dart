import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:audio_youtube/app/modules/book/widgets/button_border.dart';
import 'package:audio_youtube/app/modules/book/widgets/description_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/info_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/other_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/price_widget.dart';
import 'package:audio_youtube/app/views/folder/tabbar_folder.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:get/get.dart';
import '../../../core/const.dart';
import '../../../core/values/app_borders.dart';
import '../../../core/values/text_styles.dart';

class BookView extends StatelessWidget {
  const BookView(this.instanceController, {super.key});
  static const name = "book";
  final BookController instanceController;
  @override
  Widget build(BuildContext context) {
    instanceController.context = context;
    return SafeArea(
      child: Scaffold(
        key: DataRepository.instance.scaffoldKey,
        body: CustomScrollView(slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabbarFolder(
                tabs: const {"Thông tin": true, "Mô tả": false},
                fct: (value) {
                  instanceController.tab(value);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: PageView(
                  controller: instanceController.pageController,
                  onPageChanged: (value) {
                    instanceController.indext.value = value;
                  },
                  children: [_info(), _detail()],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: instanceController.model.type == Const.typeRSS
                    ? _rssAction()
                    : _dtruyenAction()),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OtherBookWidget(),
            ),
          ),
          _comment(),
        ]),
      ),
    );
  }

  Widget _dtruyenAction() {
    return Column(
      children: [
        const PriceWidget(
          price: 50000,
        ),
        10.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBorder(
                title: "Nghe thử",
                icon: AppIcons.audioPlay,
                fct: () {
                  instanceController.dtruyenPlay();
                }),
            10.w,
            ButtonBorder(
                title: "Mua truyện",
                icon: AppIcons.buy,
                fct: () {
                  instanceController.playDemo();
                }),
          ],
        )
      ],
    );
  }

  Widget _rssAction() {
    return Column(
      children: [
        Obx(() => PriceWidget(
              price: instanceController.bookModel.value.price ?? 0,
            )),
        10.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBorder(
                title: "Nghe thử",
                icon: AppIcons.audioPlay,
                fct: () {
                  instanceController.playDemo();
                }),
          ],
        )
      ],
    );
  }

  Widget _info() {
    return Card(
      child: Obx(
        () => Row(
          children: [
            CacheImage(
              url: instanceController.model.img,
              height: 180,
              width: 120,
              borderRadius: BorderRadius.circular(10),
            ),
            10.w,
            Expanded(
                child: InfoWidget(
              model: instanceController.bookModel.value,
            )),
          ],
        ),
      ),
    );
  }

  Widget _detail() {
    return Card(
        child: Obx(
      () => SizedBox(
          height: 220,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DescriptionWidget(
              detail: instanceController.bookModel.value.detail ?? '',
            ),
          ))),
    ));
  }

  Widget _comment() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft,
            right: AppValues.paddingRight,
            top: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppBorders.borderCardItem,
            border: const Border(
              top: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bình Luận:',
                style: headerStyle,
              ),
              // 5.h,
              // for (var item in dataTestComments.entries)
              //   Container(
              //     padding: const EdgeInsets.all(5),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           item.key,
              //           style: textStyle,
              //         ),
              //         Text(
              //           item.value,
              //           style: textStyle.copyWith(color: Colors.grey),
              //         ),
              //       ],
              //     ),
              //   ),
              // 5.h,
              // TextFormField(
              //   decoration: const InputDecoration(
              //       hintText: 'Bình luận',
              //       suffixIcon: Icon(Icons.send),
              //       border: OutlineInputBorder()),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
