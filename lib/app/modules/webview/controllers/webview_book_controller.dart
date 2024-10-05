import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/base/base_controller.dart';

import 'package:audio_youtube/app/data/model/config_website.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/conver_string.dart';

class WebViewBookController extends BaseController with WidgetsBindingObserver {
  DataRepository get _dataRepository => DataRepository.instance;
  ConfigWebsiteModel? get _configWebsite => _dataRepository.configWebsite;

  final String url;

  WebViewBookController({required this.url});

  InAppWebViewController? webViewController;
  final List<ContentBlocker> contentBlockers = [];

  RxBool loading = false.obs;

  RxInt processUI = 0.obs;

  bool isBackGround = false;

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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    webViewController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        // Ứng dụng chuyển sang background
        isBackGround = true;
        break;
      case AppLifecycleState.resumed:
        isBackGround = false;
        break;
      // Ứng dụng quay trở lại foreground
      default:
        break;
    }
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

  void onWebViewCreated(InAppWebViewController controller) {
    debugPrint('onWebViewCreated');
    webViewController = controller;
  }

  void onLoadStart(InAppWebViewController controller, WebUri? url) {
    loading.value = true;
  }

  void onProgressChanged(InAppWebViewController controller, int process) async {
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

  void onLoadStop(InAppWebViewController controller, WebUri? url) async {
    await Future.delayed(const Duration(seconds: 3));
    String st = """document.querySelector('div.description');""";
    debugPrint(st);
    final text = await controller.evaluateJavascript(source: st);
    debugPrint("$text");
  }

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

  Future<List<MediaItem>> getText() async {
    // await Future.delayed(const Duration(seconds: 3));
    String st = """(function() {
      const paragraphs = document.querySelectorAll('#bookContentBody p');
      const textArray = [];

      paragraphs.forEach((p) => {
        textArray.push(p.textContent.trim());
      });

      const jsonResult = JSON.stringify(textArray);
      return  jsonResult;
      })();
    """;
    final text = await webViewController?.evaluateJavascript(source: st);
    final json = jsonDecode(text.toString()) as List;
    List<MediaItem> listItem = [];
    for (var element in json) {
      String text = ConvertString.xoaKyTuDacBiet(element.toString());
      listItem.add(MediaItem(
          id: 'TTS', title: 'Text to speech', extras: {'number': text}));
    }
    return listItem;
  }

  void scrollPlaylistChapter() {
    String st = """document.querySelector('.volume-list').scrollIntoView({
      behavior: 'smooth', // Optional: Makes the scroll smooth
      block: 'start',     // Scrolls to the top of the element
      inline: 'nearest'   // Scrolls to the nearest edge in the inline direction
    });""";
    webViewController?.evaluateJavascript(source: st);
  }

  void play() async {
    await SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.text);
    final data = await getText();
    if (data.isNotEmpty) {
      await DataRepository.instance.pannelClose();
      await SingletonAudiohanle.instance.audioHandler?.updateQueue(data);
      await SingletonAudiohanle.instance.audioHandler?.play();
      auto();
    } else {
      scrollPlaylistChapter();
    }
  }

  void auto() async {
    final auto = await browerNextChapter();
    await Future.delayed(const Duration(seconds: 2));
    for (int i = 0; i < 20; ++i) {
      debugPrint("auto $i");
      if (isBackGround) {
        break;
      }
      if (auto == true) {
        final data = await getText();
        await SingletonAudiohanle.instance.audioHandler?.addQueueItems(data);
        await browerNextChapter();
        await Future.delayed(const Duration(seconds: 2));
      } else {
        break;
      }
    }
  }

  Future<bool> browerNextChapter() async {
    final response =
        await webViewController?.evaluateJavascript(source: """(function() {
          const btnNextChapter = document.querySelector("#btnNextChapter");

          if (btnNextChapter) {
              btnNextChapter.click();
              return true;
          } else {
              return false;
          }
        })();
        """);
    if (response is bool) {
      return response;
    } else {
      return false;
    }
  }

  void browerBack() {
    loading.value = true;
    webViewController?.canGoBack();
  }

  void browerReload() {
    loading.value = true;
    webViewController?.reload();
  }

  void browerCancel() {
    loading.value = false;
    webViewController?.stopLoading();
  }

  void download() {}

  void favorite() {}

  void backResultSearch() async {
    loading.value = true;
    webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }
}
