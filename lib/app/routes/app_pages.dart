import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/search/views/search_view.dart';
import 'package:audio_youtube/app/modules/webview/controllers/webview_book_controller.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
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
    ShellRoute(
        navigatorKey: shellRouteNavigatorKey,
        builder: (context, state, child) => RootApp(child: child),
        routes: [
          GoRoute(
              path: "/",
              name: HomeView.name,
              // redirect: (context, state) {
              //   //if khởi động lần đầu thì mở màn giới thiệu

              //   // if (auth == null && !KVStoreService.doneGettingStarted) {
              //   //   return "/getting-started";
              //   // }

              //   return null;
              // },
              builder: (context, state) => GetBuilder(
                    init: HomeController(),
                    dispose: (state) {
                      Get.delete<HomeController>();
                    },
                    builder: (controller) => HomeView(),
                  ),
              routes: [
                GoRoute(
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
                              builder: (controller) => const WebViewBookView(),
                            );
                          }),
                    ]),
              ]),
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
