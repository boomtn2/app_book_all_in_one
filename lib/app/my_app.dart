import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../gen/fonts.gen.dart';
import 'bindings/init_binding.dart';
import 'core/values/app_colors.dart';
import 'routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppPages.routes;
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Truyện",
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      backButtonDispatcher: router.backButtonDispatcher,
      initialBinding: InitBinding(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: _getSupportedLocal(),
      theme: ThemeData(
        primarySwatch: AppColors.colorPrimarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.colorPrimary,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: FontFamily.afacad,
      ),
    );
  }
}

List<Locale> _getSupportedLocal() {
  return [
    const Locale('en', ''),
    const Locale('bn', ''),
  ];
}
