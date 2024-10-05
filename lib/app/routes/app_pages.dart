import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/modules/book/controllers/book_controller.dart';
import 'package:audio_youtube/app/modules/book/views/book_view.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/search/views/search_view.dart';
import 'package:audio_youtube/app/modules/webview/controllers/webview_book_controller.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/controller/detail_video_youtube_controller.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/view/detail_video_youtube_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/root/app_root.dart';
import '../modules/search/controllers/search_controller.dart';
part 'app_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRouteNavigatorKey = GlobalKey<NavigatorState>();

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static final routes = GoRouter(navigatorKey: rootNavigatorKey, routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, child) => RootApp(child: child),
        branches: [
          StatefulShellBranch(navigatorKey: shellRouteNavigatorKey, routes: [
            GoRoute(
                parentNavigatorKey: shellRouteNavigatorKey,
                path: "/",
                name: HomeView.name,
                builder: (context, state) => GetBuilder(
                      init: HomeController(),
                      dispose: (state) {
                        Get.delete<HomeController>();
                      },
                      builder: (controller) => HomeView(),
                    ),
                routes: [
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "search",
                      name: SearchView.name,
                      builder: (context, state) => GetBuilder(
                            init: SearchBookController(),
                            dispose: (state) {
                              Get.delete<SearchBookController>();
                            },
                            builder: (controller) => const SearchView(),
                          ),
                      routes: [
                        GoRoute(
                            parentNavigatorKey: shellRouteNavigatorKey,
                            path: "webview",
                            name: WebViewBookView.name,
                            builder: (context, state) {
                              assert(state.extra is String);
                              String url = state.extra as String;
                              debugPrint(url);
                              return GetBuilder(
                                init: WebViewBookController(url: url),
                                dispose: (state) {
                                  Get.delete<WebViewBookController>();
                                },
                                builder: (controller) =>
                                    const WebViewBookView(),
                              );
                            }),
                      ]),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "detailytb",
                      name: DetailVideoYoutubeView.name,
                      builder: (context, state) {
                        assert(state.extra is BookModel);
                        BookModel model = state.extra as BookModel;
                        return GetBuilder(
                          init: DetailVideoYoutubeController(bookModel: model),
                          dispose: (state) {
                            Get.delete<DetailVideoYoutubeController>();
                          },
                          builder: (controller) =>
                              DetailVideoYoutubeView(controller),
                        );
                      }),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "book",
                      name: BookView.name,
                      builder: (context, state) {
                        assert(state.extra is BookModel);
                        BookModel model = state.extra as BookModel;
                        return GetBuilder(
                          init: BookController(model: model),
                          dispose: (state) {
                            Get.delete<BookController>();
                          },
                          builder: (controller) => BookView(controller),
                        );
                      }),
                ]),
          ])
        ]),
    GoRoute(
      path: "/login",
      name: LoginView.name,
      builder: (context, state) {
        LoginBinding();
        return const LoginView();
      },
    ),
  ]);
}
