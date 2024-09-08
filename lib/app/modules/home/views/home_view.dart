import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/player_youtube/views/player_youtube_view.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:audio_youtube/app/views/views/item_card_book_view.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/values/app_borders.dart';
import '../../../core/values/text_styles.dart';
import '../../../data/repository/player_youtube_repository.dart';
import '../../../views/folder/tabbar_folder.dart';
import '../../../views/views/item_card_book_horital_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PopScope(
          child: SlidingUpPanel(
            maxHeight: MediaQuery.sizeOf(context).height,
            minHeight: 80,
            parallaxEnabled: true,
            parallaxOffset: .5,
            controller: controller.panelController,
            defaultPanelState: PanelState.CLOSED,
            body: _body(context),
            onPanelClosed: () {
              controller.hideBottomNavigator();
            },
            onPanelOpened: () {
              controller.showBottomNavigator();

              //show full
            },
            onPanelSlide: (position) {
              // print('onPanelSlide');
            },
            collapsed: Container(
              color: Colors.black,
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CacheImage(
                    url: PlayerYoutubeRepository.instance.bookListen?.img ?? '',
                    borderRadius: BorderRadius.circular(4),
                    height: 80,
                    width: 100,
                  ),
                  10.w,
                  Expanded(
                    child: Text(
                      PlayerYoutubeRepository.instance.bookListen?.title ?? '',
                      maxLines: 1,
                      style: titleStyleWhite,
                    ),
                  ),
                  10.w,
                  IconButton(
                      onPressed: () {
                        controller.closedPannel();
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      )),
                  20.w,
                ],
              ),
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panelBuilder: (sc) => PlayerYoutubeView(
              sc: sc,
            ),
          ),
        ),
        bottomNavigationBar: controller.isHideBottomNavigator.value
            ? null
            : Container(
                color: Colors.yellow,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.home),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.person_2_outlined),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _itemAppBar(context),
        _space(),
        _title({'Đề xuất': true, 'Chọn lọc': false, 'Đã tải': false}),
        Obx(
          () => _itemNew(controller.videoYoutube,
              MediaQuery.sizeOf(context).height, controller.openDetail),
        ),
        _space(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Truyện Dịch',
                      style: titleStyle,
                    ),
                  ],
                ),
                5.h,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      child: Row(
                        children: [
                          for (int i = 0;
                              i < controller.videoRSS.length / 2;
                              ++i)
                            Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ItemCardBookView(
                                      book: controller.videoRSS
                                          .getNullIndex(i * 2),
                                    ),
                                    10.h,
                                    ItemCardBookView(
                                      book: controller.videoRSS
                                          .getNullIndex((i * 2) + 1),
                                    ),
                                  ],
                                ),
                                5.w,
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _space(),
        _itemListBook(context),
      ],
    );
  }

  Widget _title(Map<String, bool> tabs) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft, right: AppValues.paddingRight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabbarFolder(
              tabs: tabs,
              fct: (value) {},
            ),
            5.h,
          ],
        ),
      ),
    );
  }

  Widget _itemListBook(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft, right: AppValues.paddingRight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: AppBorders.borderCardItem,
                  border: const Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  )),
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Tên truyện',
                        style: headerStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Expanded(
                      flex: 1,
                      child: Text('Tác giả',
                          style: headerStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                  Expanded(
                      flex: 1,
                      child: Text('Lượt đọc',
                          style: headerStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))
                ],
              ),
            ),
            5.h,
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: AppBorders.borderCardItem,
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    _buttonTitleBook(),
                    10.h,
                    _buttonLoadmore(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonLoadmore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: AppBorders.borderCardItem,
          border: const Border(
              top: BorderSide(
            width: 2,
            color: Colors.red,
          ))),
      child: Text(
        'Xem thêm',
        style: textButtonStyle.copyWith(fontSize: 14),
      ),
    );
  }

  Widget _buttonTitleBook() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  'MANG THEO KHÔNG GIAN LÀM THANH NIÊN TRI THỨC (PHIÊN NGOẠI)',
                  style: titleStyle.copyWith(fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
            5.w,
            Expanded(
                flex: 1,
                child: Text('Ngô Tất tố',
                    style: titleStyle.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
            5.w,
            Expanded(
                flex: 1,
                child: Text('View',
                    style: titleStyle.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        2.h,
        const Divider()
      ],
    );
  }

  Widget _space() {
    return const SliverExpandedView(
      height: AppValues.expandedItem,
    );
  }

  Widget _itemNew(
      List<BookModel> ytb, double sizeMax, Function(BookModel) openDetail) {
    return SliverToBoxAdapter(
        child: ytb.isEmpty
            ? const Loading()
            : Container(
                margin: const EdgeInsets.only(
                    left: AppValues.paddingLeft, right: AppValues.paddingRight),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: AppBorders.borderCardItem,
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      width: sizeMax,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          child: Row(
                            children: [
                              for (int i = 0; i < ytb.length / 2; ++i)
                                Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ItemCardBookHoritalView(
                                          book: ytb.getNullIndex(i * 2),
                                          openDetail: openDetail,
                                        ),
                                        10.h,
                                        ItemCardBookHoritalView(
                                          book: ytb.getNullIndex((i * 2) + 1),
                                          openDetail: openDetail,
                                        ),
                                      ],
                                    ),
                                    20.w,
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.h,
                    _buttonLoadmore(),
                  ],
                )));
  }

  Widget _itemAppBar(BuildContext context) {
    return SliverAppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Row(
              children: [
                InkWell(
                  //Todo:  menu
                  onTap: () {},
                  child: const Icon(
                    Icons.menu,
                    size: 32,
                  ),
                ),
                12.w,
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 14),
                            hintText: 'Tìm kiếm',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            suffixIcon: const Icon(Icons.search)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: bigTitleStyle,
        ),
      ],
    );
  }
}

class DetailBookInforView extends StatelessWidget {
  const DetailBookInforView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: const Color(0xFFE0E0DC),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/book.jpeg'),
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Thập niên 70...',
                maxLines: 1,
              ),
              Text(
                'Tác giả',
                maxLines: 1,
              ),
              Text(
                'Mô tả',
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SliverBannerView extends StatelessWidget {
  const SliverBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft, right: AppValues.paddingRight),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleView(
                  title: "Chọn lọc",
                ),
                Text(
                  'Xem thêm',
                  style: fontStyteLoadMore,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 120,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://i.ytimg.com/vi/KPssR-ReIds/hqdefault.jpg',
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: 10,
                viewportFraction: 0.6,
                scale: 0.8,
                autoplayDelay: 4000,
                autoplay: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverExpandedView extends StatelessWidget {
  const SliverExpandedView({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}

class ImageBookView extends StatelessWidget {
  const ImageBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: const DecorationImage(
                    image: AssetImage('assets/images/book.jpeg'),
                    fit: BoxFit.fill)),
          ),
          const Text('Mang không gian xuyên 80, kiều phu hắn lại ngọt lại dã',
              maxLines: 3, textAlign: TextAlign.center, style: titleStyle),
        ],
      ),
    );
  }
}
