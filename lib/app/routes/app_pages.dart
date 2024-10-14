import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/model/channel_model.dart';
import 'package:audio_youtube/app/modules/book/controllers/book_controller.dart';
import 'package:audio_youtube/app/modules/book/views/book_view.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/loadmore/loadmore_controller.dart';
import 'package:audio_youtube/app/modules/loadmore/loadmore_view.dart';
import 'package:audio_youtube/app/modules/post_card/post_card_controller.dart';
import 'package:audio_youtube/app/modules/post_card/post_card_view.dart';
import 'package:audio_youtube/app/modules/search/views/search_view.dart';
import 'package:audio_youtube/app/modules/slash/slash_view.dart';
import 'package:audio_youtube/app/modules/webview/controllers/webview_book_controller.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:audio_youtube/app/modules/youtube/channel/channel_youtuebe_controller.dart';
import 'package:audio_youtube/app/modules/youtube/channel/view/channel_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/controller/detail_video_youtube_controller.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/view/detail_video_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/loadmore/channel_youtuebe_controller.dart';
import 'package:audio_youtube/app/modules/youtube/loadmore/view/channel_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/playlist_channels/playlist_channels_controller.dart';
import 'package:audio_youtube/app/modules/youtube/playlist_channels/playlist_channels_view.dart';
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
final shellSettingRouteNavigatorKey = GlobalKey<NavigatorState>();

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static final routes = GoRouter(navigatorKey: rootNavigatorKey, routes: [
    GoRoute(
      path: "/",
      name: SlashView.name,
      builder: (context, state) {
        return const SlashView();
      },
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, child) => RootApp(child: child),
        branches: [
          StatefulShellBranch(navigatorKey: shellRouteNavigatorKey, routes: [
            GoRoute(
                parentNavigatorKey: shellRouteNavigatorKey,
                path: "/home",
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
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "loadmore",
                      name: LoadMoreView.name,
                      builder: (context, state) {
                        assert(state.extra is List<BookModel>);
                        List<BookModel> models = state.extra as List<BookModel>;
                        return GetBuilder(
                          init: LoadMoreController(books: models),
                          dispose: (state) {
                            Get.delete<LoadMoreController>();
                          },
                          builder: (controller) => LoadMoreView(
                            controller: controller,
                          ),
                        );
                      }),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "channel-youtube",
                      name: ChannelYoutubeView.name,
                      builder: (context, state) {
                        assert(state.extra is ChannelModel);
                        ChannelModel models = state.extra as ChannelModel;
                        return GetBuilder(
                          init: ChannelYoutuebeController(channelModel: models),
                          dispose: (state) {
                            Get.delete<ChannelYoutuebeController>();
                          },
                          builder: (controller) => ChannelYoutubeView(
                            channelYoutuebeController: controller,
                          ),
                        );
                      }),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "loadmore-playlist-youtube",
                      name: LoadMorePlayListYoutubeView.name,
                      builder: (context, state) {
                        assert(state.extra is List<BookModel>);
                        List<BookModel> models = state.extra as List<BookModel>;
                        return GetBuilder(
                          init:
                              LoadMorePlayListController(channelModel: models),
                          dispose: (state) {
                            Get.delete<LoadMorePlayListController>();
                          },
                          builder: (controller) => LoadMorePlayListYoutubeView(
                            channelYoutuebeController: controller,
                          ),
                        );
                      }),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "playlist-channels",
                      name: PlaylistChannelsView.name,
                      builder: (context, state) {
                        assert(state.extra is List<ChannelModel>);
                        List<ChannelModel> models =
                            state.extra as List<ChannelModel>;
                        return GetBuilder(
                          init: PlaylistChannelsController(channels: models),
                          dispose: (state) {
                            Get.delete<PlaylistChannelsController>();
                          },
                          builder: (controller) => PlaylistChannelsView(
                            controller: controller,
                          ),
                        );
                      }),
                  GoRoute(
                      parentNavigatorKey: shellRouteNavigatorKey,
                      path: "post-card-vnepress",
                      name: PostCardView.name,
                      builder: (context, state) {
                        assert(state.extra is BookModel);
                        BookModel model = state.extra as BookModel;
                        return GetBuilder(
                          init: PostCardController(introPostCard: model),
                          dispose: (state) {
                            Get.delete<PostCardController>();
                          },
                          builder: (controller) => PostCardView(
                            controller: controller,
                          ),
                        );
                      }),
                ]),
          ]),
          StatefulShellBranch(
              navigatorKey: shellSettingRouteNavigatorKey,
              routes: [
                GoRoute(
                    path: "/search",
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
                          parentNavigatorKey: shellSettingRouteNavigatorKey,
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
