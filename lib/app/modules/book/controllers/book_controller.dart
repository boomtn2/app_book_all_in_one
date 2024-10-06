import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/remote/gist/rss_remote.dart';
import 'package:audio_youtube/app/data/repository/html_repository.dart';
import 'package:audio_youtube/app/data/repository/rss_repository.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:audio_youtube/app/modules/book/widgets/button_border.dart';
import 'package:audio_youtube/app/modules/book/widgets/description_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/info_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/other_widget.dart';
import 'package:audio_youtube/app/modules/book/widgets/price_widget.dart';
import 'package:audio_youtube/app/views/folder/tabbar_folder.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../../../../data_test/data_test.dart';
import '../../../core/values/app_borders.dart';
import '../../../core/values/text_styles.dart';

class BookController extends GetxController {
  RxInt indext = 0.obs;
  Rx<BookModel> bookModel = BookModel(
          title: 'Chưa có dữ liệu',
          author: 'Chưa có dữ liệu',
          img: '',
          type: '')
      .obs;

  List<BookModel> list = [];

  final RssRepository rss = RssRepositoryIml();
  final HtmlRepository html = HtmlRepositoryImpl();
  final BookModel model;
  BuildContext? context;
  BuildContext? contextDialog;

  ChapterModel? _linkChapter;

  BookController({required this.model}) {
    _init();
  }

  void _init() async {
    if (model.type == Const.typeRSS) {
      final _list = await rss.getPlayList(model.id ?? '');
      if (_list.isNotEmpty) {
        model.detail = _list[0].detail;
        list = _list;
      }
    } else {
      final data = await html.dtruyenFetchInforBook(model.id ?? '');
      _linkChapter = data.$1;
      model.detail = data.$2.detail;
      model.view = data.$2.view;
      model.status = data.$2.status;
      model.category = data.$2.category;
    }

    bookModel.value = model;
  }

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  void tab(String tab) {
    if (tab.contains('Mô tả')) {
      indext.value = 1;
      _pageController.jumpToPage(1);
    } else {
      indext.value = 0;
      _pageController.jumpToPage(0);
    }
  }

  void showDialogProgress() {
    if (context != null) {
      showDialog(
          context: context!,
          builder: (context) {
            contextDialog = context;
            return AlertDialog(
              title: const Text('Tiến trình'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder(
                    valueListenable: processingDownloadChapter,
                    builder: (context, value, child) {
                      return Text("$value /50 Chapter");
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isCancelDownload = true;
                      CancelToken cancelToken = CancelToken();
                      cancelToken.cancel();
                      Navigator.canPop(context);
                    },
                    child: const Text('Hủy tải'),
                  )
                ],
              ),
            );
          });
    }
  }

  List<Widget> itemBuilder(BuildContext context) {
    this.context = context;
    if (bookModel.value.type.contains(AppValues.typePlayListYoutube) == true) {
      return [];
    } else if (bookModel.value.type.contains(AppValues.typeVideoYoutube) ==
        true) {
      return [];
    } else {
      return [
        const SliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabbarFolder(
              tabs: const {"Thông tin": true, "Mô tả": false},
              fct: (value) {
                tab(value);
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
                controller: _pageController,
                onPageChanged: (value) {
                  indext.value = value;
                },
                children: [_info(), _detail()],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: model.type == Const.typeRSS
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
      ];
    }
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
                  _dtruyenPlay();
                }),
            10.w,
            ButtonBorder(
                title: "Mua truyện",
                icon: AppIcons.buy,
                fct: () {
                  _playDemo();
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
              price: bookModel.value.price ?? 0,
            )),
        10.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBorder(
                title: "Nghe thử",
                icon: AppIcons.audioPlay,
                fct: () {
                  _playDemo();
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
              url: model.img,
              height: 180,
              width: 120,
              borderRadius: BorderRadius.circular(10),
            ),
            10.w,
            Expanded(
                child: InfoWidget(
              model: bookModel.value,
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
              detail: bookModel.value.detail ?? '',
            ),
          ))),
    ));
  }

  Widget _sliverNull() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Loading(),
      ),
    );
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
              5.h,
              for (var item in dataTestComments.entries)
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.key,
                        style: textStyle,
                      ),
                      Text(
                        item.value,
                        style: textStyle.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              5.h,
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Bình luận',
                    suffixIcon: Icon(Icons.send),
                    border: OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _playDemo() {
    if (list.isNotEmpty) {
      SingletonAudiohanle.instance.audioHandler?.updateQueue([
        MediaItem(
            id: list.last.id ?? '',
            title: list.last.title,
            artUri: Uri.tryParse(list.last.img))
      ]);
    }
  }

  void _dtruyenPlay() async {
    await SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.text);
    _auto50Chapter();
  }

  ValueNotifier<int> processingDownloadChapter = ValueNotifier(0);
  bool isCancelDownload = false;
  void _auto50Chapter() async {
    processingDownloadChapter = ValueNotifier(0);
    showDialogProgress();
    for (int i = 0; i < 50; ++i) {
      processingDownloadChapter.value = i;
      if (isCancelDownload) {
        break;
      }
      if (_linkChapter != null) {
        _linkChapter =
            await html.dtruyenFetchChapter(_linkChapter?.linkNext ?? '');
        if (_linkChapter?.text != null) {
          SingletonAudiohanle.instance.audioHandler?.addQueueItem(MediaItem(
              id: '',
              title: _linkChapter?.title ?? "",
              extras: {"number": _linkChapter?.text ?? ""}));
        }

        if (i == 0) {
          SingletonAudiohanle.instance.audioHandler?.play();
        }
        await Future.delayed(const Duration(seconds: 5));
      } else {
        break;
      }
    }

    processingDownloadChapter.dispose();
  }
}
