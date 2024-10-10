import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/utils/conver_string.dart';
import 'package:audio_youtube/app/data/remote/youtube/param_models/youtube_search_param_model.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:audio_youtube/app/views/dialogs/dialog_progress.dart';
import 'package:flowery_tts/flowery_tts.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../model/models_export.dart';
import 'html_repository.dart';

class DataRepository {
  static DataRepository get instance => _getInstance();
  static DataRepository? _instance;

  static DataRepository _getInstance() {
    return _instance ??= DataRepository._internal();
  }

  factory DataRepository() => _getInstance();

  DataRepository._internal();

  ConfigWebsiteModel? configWebsite;
  ListSearchTag? tagSearch;
  ListSearchName? nameSearch;
  List<WebsiteTag>? tagWebsite;
  final PanelController panelController = PanelController();
  AnimationController? animationController;
  BookModel? model;
  ChapterModel? chapterModel;
  BuildContext? contextDialog;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  YoutubeSearchParamModel? youtubeSearchParamModel;
  String? urlDtruyen;

  FlowerRemote _flowerRemote = FlowerRemote();

  void flowerTTS() async {
    bool firt = true;
    final list = ConvertString.splipMaxLenght(example, 500);
    for (int i = 0; i < list.length; ++i) {
      final uri = await _flowerRemote.createAudio('$i', list[i]);
      await changeChannelMp3();

      firt
          ? await newQueues([MediaItem(id: uri, title: "Flower API$i")])
          : addQueue(MediaItem(id: uri, title: "Flower API $i"));
      firt = false;
    }
  }

  void avatarPlay() {
    animationController?.repeat();
  }

  void avatarStop() {
    animationController?.stop();
  }

  Future pannelClose() async {
    if (panelController.isPanelClosed == false) {
      await pannelShow();
      await panelController.close();
    }
  }

  Future pannelOpen() async {
    if (panelController.isPanelOpen == false) {
      await pannelShow();
      await panelController.open();
    }
  }

  Future pannelShow() async {
    if (panelController.isPanelShown == false) {
      await panelController.show();
    }
  }

  Future pannelHide() async {
    if (panelController.isPanelShown) {
      await panelController.hide();
    }
  }

  DownloadText? _downloadText;

  void stopAllDownload() {
    _downloadText?.stopLoop();
    // audioHanle?.stop();
    closeDialog();
  }

  void startDownloadText(int max, BuildContext context) async {
    await changeChannelTTS();
    _downloadText?.fetchChapters(max);
  }

  void newDownloadText(ChapterModel chapter) {
    _downloadText = DownloadText(openDialogProgress, closeDialog,
        linkChapter: chapter, setMedia: (media, firt) {
      firt ? newQueues([media]) : addQueue(media);
    });
  }

  Future changeChannelTTS() async {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.text);
  }

  Future changeChannelMp3() async {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
  }

  void openDialogProgress() {
    if (scaffoldKey.currentContext != null && _downloadText != null) {
      showDialog(
        context: scaffoldKey.currentContext!,
        builder: (_) {
          contextDialog = _;
          return DialogProgress(
              notifier: _downloadText!.processingDownloadChapter,
              callBack: () {
                Navigator.pop(_);
                contextDialog = null;
                _downloadText!.stopLoop();
              });
        },
      );
    }
  }

  void closeDialog() {
    if (contextDialog != null) {
      Navigator.pop(contextDialog!);
      contextDialog = null;
    }
  }

  AudioHandler? get audioHanle => SingletonAudiohanle.instance.audioHandler;

  void playAudio() {
    if (audioHanle == null) {
      initAudio();
    } else {
      stopAudio();
      audioHanle?.play();
    }
  }

  String example = '';
  void addQueue(MediaItem item) {
    example = item.extras?["number"];
    audioHanle?.addQueueItem(item);
  }

  Future newQueues(List<MediaItem> items) async {
    await audioHanle?.updateQueue(items);
    playAudio();
  }

  void stopAudio() {
    audioHanle?.stop();
  }

  Future initAudio() async {
    await SingletonAudiohanle.instance.init();
  }
}

class DownloadText {
  ValueNotifier<int> processingDownloadChapter = ValueNotifier(0);
  bool isCancelDownload = false;
  int cacheIndex = 0;
  ChapterModel linkChapter;
  final HtmlRepository html = HtmlRepositoryImpl();
  final Function(MediaItem, bool) setMedia;

  final Function openDialogProgress;
  final Function closeDialogProgress;

  DownloadText(
    this.openDialogProgress,
    this.closeDialogProgress, {
    required this.linkChapter,
    required this.setMedia,
  });

  void dispose() {
    stopLoop();
    processingDownloadChapter.dispose();
  }

  void stopLoop() {
    isCancelDownload = true;
  }

  void fetchChapters(int max) async {
    processingDownloadChapter.value = cacheIndex;
    openDialogProgress();
    for (cacheIndex; cacheIndex < max; ++cacheIndex) {
      processingDownloadChapter.value = cacheIndex;

      if (isCancelDownload) {
        break;
      }

      linkChapter = await html.dtruyenFetchChapter(linkChapter.linkNext);
      if (linkChapter.text.trim().isNotEmpty) {
        if (cacheIndex == 0) {
          newQueueText();
        } else {
          addQueueText();
        }
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    closeDialogProgress();
    isCancelDownload = false;
  }

  void addQueueText() {
    setMedia(
        MediaItem(
            id: linkChapter.linkChapter,
            title: linkChapter.title,
            extras: {"number": linkChapter.text}),
        false);
  }

  void newQueueText() {
    setMedia(
        MediaItem(
            id: linkChapter.linkChapter,
            title: linkChapter.title,
            extras: {"number": linkChapter.text}),
        true);
  }
}

class FlowerRemote {
  List<Voice> listVoice = [];
  final flowery = const Flowery();

  //flower api
  void flowerTTS() async {
    final voices = await flowery.voices();
    listVoice = List.from(voices.voices.where(
      (element) => element.language.code.contains("vi-VN"),
    ));
  }

  Future<String> createAudio(String name, String text,
      {String voice = "Hoai"}) async {
    final audio = await flowery.tts(text: text, voice: voice);
    final path = await getApplicationDocumentsDirectory();
    final String pathSave = '${path.path}/$name.mp3';
    File(pathSave).writeAsBytesSync(audio);
    return pathSave;
  }

  void dispose() {
    flowery.close();
  }
}
