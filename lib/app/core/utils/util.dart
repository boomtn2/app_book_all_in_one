import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Util {
  static bool imageOk(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('http')) {
      return false;
    }
    return true;
  }

  //Dùng cho bottom navigator
  static void navigate(BuildContext context, String location, {Object? extra}) {
    if (GoRouterState.of(context).matchedLocation == location) return;
    GoRouter.of(context).go(location, extra: extra);
  }

  //Dùng cho bottom navigator
  static void navigateNamed(
    BuildContext context,
    String name, {
    Object? extra,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    if (GoRouterState.of(context).matchedLocation == name) return;
    GoRouter.of(context).goNamed(
      name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  //Dùng chuyển page
  static void push(BuildContext context, String location, {Object? extra}) {
    final router = GoRouter.of(context);
    final routerState = GoRouterState.of(context);
    final routerStack = router.routerDelegate.currentConfiguration.matches
        .map((e) => e.matchedLocation);

    if (routerState.matchedLocation == location ||
        routerStack.contains(location)) return;
    router.push(location, extra: extra);
  }

  // //Dùng chuyển page
  // static void pushNamed(
  //   BuildContext context,
  //   String name, {
  //   Object? extra,
  //   Map<String, String> pathParameters = const {},
  //   Map<String, String> queryParameters = const {},
  // }) {
  //   final router = GoRouter.of(context);
  //   final routerState = GoRouterState.of(context);
  //   final routerStack = router.routerDelegate.currentConfiguration.matches
  //       .map((e) => e.matchedLocation);

  //   final nameLocation = routerState.namedLocation(
  //     name,
  //     pathParameters: pathParameters,
  //     queryParameters: queryParameters,
  //   );

  //   if (routerState.matchedLocation == nameLocation ||
  //       routerStack.contains(nameLocation)) {
  //     return;
  //   }
  //   router.pushNamed(
  //     name,
  //     pathParameters: pathParameters,
  //     queryParameters: queryParameters,
  //     extra: extra,
  //   );
  // }
}
