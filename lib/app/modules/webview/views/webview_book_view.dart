import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import '../controllers/webview_book_controller.dart';

class WebViewBookView extends GetView<WebViewBookController> {
  const WebViewBookView({super.key});
  static const String name = 'webview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _button(
                    AppIcons.browerBack, 'Trang trước', controller.browerBack),
                _button(
                    AppIcons.browerReload, 'Tải lại', controller.browerReload),
                _button(AppIcons.searchResult, 'Truyện',
                    controller.backResultSearch),
                _button(AppIcons.scroll, 'Chapter',
                    controller.scrollPlaylistChapter),
              ],
            )),
      ),
      body: Obx(
        () => Stack(
          children: [
            Column(children: <Widget>[
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: controller.request(),
                  initialSettings: controller.init(),
                  onWebViewCreated: controller.onWebViewCreated,
                  onLoadStart: controller.onLoadStart,
                  onProgressChanged: controller.onProgressChanged,
                  onLoadStop: controller.onLoadStop,
                  onReceivedError: controller.onReceivedError,
                ),
              ),
            ]),
            Visibility(
              visible: controller.loading.value,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Loading(),
                    IconButton(
                        onPressed: () {
                          controller.browerCancel();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.red,
        direction: SpeedDialDirection.down,
        isOpenOnStart: true,
        children: [
          SpeedDialChild(
              onTap: controller.play,
              label: 'Nghe Audio',
              child: const Icon(
                AppIcons.audioPlay,
              )),
          SpeedDialChild(
              onTap: controller.download,
              label: 'Tải về',
              child: const Icon(
                Icons.download,
                color: Colors.blue,
              )),
          SpeedDialChild(
              onTap: controller.favorite,
              label: 'Theo dõi',
              child: const Icon(
                Icons.bookmark,
                color: Colors.yellow,
              )),
        ],
        child: SizedBox(
          width: 80,
          height: 50,
          child: Column(
            children: [
              const Icon(
                AppIcons.audioPlay,
                color: Colors.white,
              ),
              Text(
                "Nghe",
                style: afaca.s12.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(IconData icon, String title, GestureTapCallback callBack) {
    return InkWell(
      onTap: callBack,
      child: SizedBox(
        width: 80,
        height: 50,
        child: Column(
          children: [
            Icon(icon),
            Text(
              title,
              style: afaca.s12,
            ),
          ],
        ),
      ),
    );
  }
}
