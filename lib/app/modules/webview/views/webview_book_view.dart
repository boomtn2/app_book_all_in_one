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
              ))
            ]),
            Visibility(
              visible: controller.loading.value,
              child: Center(
                child: Column(
                  children: [
                    const Loading(),
                    IconButton(
                        onPressed: () {
                          controller.stopLoading();
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
        direction: SpeedDialDirection.down,
        isOpenOnStart: true,
        children: [
          SpeedDialChild(
            label: 'Phông chữ',
            child: const Icon(Icons.settings),
          ),
          SpeedDialChild(
              label: 'Tập tiếp theo',
              child: const Icon(
                Icons.skip_next,
                color: Colors.red,
              )),
          SpeedDialChild(
              label: 'Tải về',
              child: const Icon(
                Icons.download,
                color: Colors.blue,
              )),
          SpeedDialChild(label: 'Theo dõi', child: const Icon(Icons.bookmark)),
        ],
        child: const Icon(Icons.add),
      ),
    );
  }
}
