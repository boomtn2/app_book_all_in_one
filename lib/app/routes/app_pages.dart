import 'package:get/get.dart';

import '../modules/audio/bindings/audio_binding.dart';
import '../modules/audio/views/audio_view.dart';
import '../modules/book/bindings/book_binding.dart';
import '../modules/book/views/book_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

import '../modules/read_book/bindings/read_book_binding.dart';
import '../modules/read_book/views/read_book_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOOK,
      page: () => const BookView(),
      binding: BookBinding(),
    ),
    GetPage(
      name: _Paths.READ_BOOK,
      page: () => const ReadBookView(),
      binding: ReadBookBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO,
      page: () => const AudioView(),
      binding: AudioBinding(),
    ),
    // GetPage(
    //   name: _Paths.PLAYER_YOUTUBE,
    //   page: () => const PlayerYoutubeView(),
    //   binding: PlayerYoutubeBinding(),
    // ),
  ];
}
