import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../model/models_export.dart';

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
}
