import 'package:audio_youtube/app/core/base/base_controller.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewBookController extends BaseController {
  DataRepository get _dataRepository => DataRepository.instance;

  final String url;

  WebViewBookController({required this.url});

  InAppWebViewController? webViewController;
  final List<ContentBlocker> contentBlockers = [];

  RxBool loading = false.obs;

  RxInt processUI = 0.obs;

  final adUrlFilters = [
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*",
    ".*.fly-ads.net/.*",
    ".*.blueseed.tv/.*",
    ".*.yomedia.vn/.*",
    ".*.kernh41.com/.*",
    ".*.tpmedia.online/.*",
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _dataRepository.panelController.hide();
    super.onReady();
  }

  @override
  void dispose() {
    webViewController?.dispose();
    super.dispose();
  }

  void _adsBlock() {
    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector:
                ".banner, .banners, .ads, .ad, .advert, .widget-ads, .ad-unit")));
  }

  void onWebViewCreated(InAppWebViewController controller) {}
  void onLoadStart(InAppWebViewController controller, WebUri? url) {
    loading.value = true;
  }

  void onProgressChanged(InAppWebViewController controller, int process) {
    processUI.value = process;
    if (process < 10) {
      loading.value = true;
    }
    if (process > 30) {
      controller.evaluateJavascript(source: """
              // Lấy tất cả các phần tử trên trang
              var elements = document.body.getElementsByTagName("*");
              for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                // Kiểm tra nếu phần tử không phải là <main> và không là con của <main>
                if (!element.closest('main')) {
                  element.style.display = 'none';
                }
              }
            """);

      loading.value = false;
    }
  }

  void onLoadStop(InAppWebViewController controller, WebUri? url) {}

  void onReceivedError(InAppWebViewController controller, WebResourceRequest rq,
      WebResourceError error) {
    showErrorMessage('Lỗi ${error.description}');
  }

  InAppWebViewSettings init() {
    _adsBlock();
    return InAppWebViewSettings(
      clearCache: true,
      contentBlockers: contentBlockers,
    );
  }

  URLRequest request() {
    return URLRequest(url: WebUri(url));
  }

  void stopLoading() {
    webViewController?.stopLoading();
    loading.value = false;
  }
}
