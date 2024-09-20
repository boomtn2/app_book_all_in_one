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
}
