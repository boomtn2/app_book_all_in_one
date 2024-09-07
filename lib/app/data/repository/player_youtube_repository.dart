import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../modules/player_youtube/controllers/player_youtube_controller.dart';

class PlayerYoutubeRepository {
  static PlayerYoutubeRepository get instance => _getInstance();
  static PlayerYoutubeRepository? _instance;

  static PlayerYoutubeRepository _getInstance() {
    return _instance ??= PlayerYoutubeRepository._internal();
  }

  factory PlayerYoutubeRepository() => _getInstance();

  PlayerYoutubeRepository._internal();

  YoutubePlayerController? playerController;

  PlayerYoutubeController viewController = PlayerYoutubeController();

  PanelController? panelController;

  dispose() {
    panelController?.hide();
    viewController.hideViewPlayer();
    playerController?.dispose();
    playerController = null;
    viewController.dispose();
  }

  BookModel? bookListen;

  void loadVideoID(String id) {
    playerController?.pause();
    playerController?.load(id);
  }

  Future loadPlayListVideo(BookModel book) async {
    if (viewController.isClosed) {
      viewController = PlayerYoutubeController();
    }

    viewController.inforPlayList = book;
    await viewController.getListVideo();

    if (panelController?.isPanelShown != true &&
        panelController?.isPanelOpen != true) {
      bookListen = viewController.video.value;
      playerController = YoutubePlayerController(
        initialVideoId: bookListen?.id ?? '',
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
      viewController.showViewPlayer();
      panelController?.show();
    } else {
      playerController?.pause();
      playerController?.load(viewController.video.value?.id ?? '');
    }

    panelController?.open();
  }
}
