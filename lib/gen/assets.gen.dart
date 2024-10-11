/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:rive/rive.dart' as _rive;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ad-blocker.png
  AssetGenImage get adBlocker =>
      const AssetGenImage('assets/images/ad-blocker.png');

  /// File path: assets/images/avt.jpg
  AssetGenImage get avt => const AssetGenImage('assets/images/avt.jpg');

  /// File path: assets/images/book.jpeg
  AssetGenImage get book => const AssetGenImage('assets/images/book.jpeg');

  /// File path: assets/images/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/images/empty.png');

  /// File path: assets/images/give-away.gif
  AssetGenImage get giveAway =>
      const AssetGenImage('assets/images/give-away.gif');

  /// File path: assets/images/homepage-iconly-bold-play.svg
  SvgGenImage get homepageIconlyBoldPlay =>
      const SvgGenImage('assets/images/homepage-iconly-bold-play.svg');

  /// File path: assets/images/homepage-iconly-light-outline-iconly-light-outline-arrow-left-circle.svg
  SvgGenImage get homepageIconlyLightOutlineIconlyLightOutlineArrowLeftCircle =>
      const SvgGenImage(
          'assets/images/homepage-iconly-light-outline-iconly-light-outline-arrow-left-circle.svg');

  /// File path: assets/images/homepage-iconly-light-outline-iconly-light-outline-arrow-right-circle.svg
  SvgGenImage get homepageIconlyLightOutlineIconlyLightOutlineArrowRightCircle =>
      const SvgGenImage(
          'assets/images/homepage-iconly-light-outline-iconly-light-outline-arrow-right-circle.svg');

  /// File path: assets/images/homepage-iconly-light-outline-play.svg
  SvgGenImage get homepageIconlyLightOutlinePlay =>
      const SvgGenImage('assets/images/homepage-iconly-light-outline-play.svg');

  /// File path: assets/images/homepage-iconly-light-outline-volume-up.svg
  SvgGenImage get homepageIconlyLightOutlineVolumeUp => const SvgGenImage(
      'assets/images/homepage-iconly-light-outline-volume-up.svg');

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/iconly-bold-bookmark.svg
  SvgGenImage get iconlyBoldBookmark =>
      const SvgGenImage('assets/images/iconly-bold-bookmark.svg');

  /// File path: assets/images/iconly-bold-close-square.svg
  SvgGenImage get iconlyBoldCloseSquare =>
      const SvgGenImage('assets/images/iconly-bold-close-square.svg');

  /// File path: assets/images/iconly-bold-download.svg
  SvgGenImage get iconlyBoldDownload =>
      const SvgGenImage('assets/images/iconly-bold-download.svg');

  /// File path: assets/images/iconly-bold-tick-square.svg
  SvgGenImage get iconlyBoldTickSquare =>
      const SvgGenImage('assets/images/iconly-bold-tick-square.svg');

  /// File path: assets/images/iconly-light-outline-time-square.svg
  SvgGenImage get iconlyLightOutlineTimeSquare =>
      const SvgGenImage('assets/images/iconly-light-outline-time-square.svg');

  /// File path: assets/images/pause.svg
  SvgGenImage get pause => const SvgGenImage('assets/images/pause.svg');

  /// File path: assets/images/place.png
  AssetGenImage get place => const AssetGenImage('assets/images/place.png');

  /// File path: assets/images/vip.gif
  AssetGenImage get vip => const AssetGenImage('assets/images/vip.gif');

  /// List of all assets
  List<dynamic> get values => [
        adBlocker,
        avt,
        book,
        empty,
        giveAway,
        homepageIconlyBoldPlay,
        homepageIconlyLightOutlineIconlyLightOutlineArrowLeftCircle,
        homepageIconlyLightOutlineIconlyLightOutlineArrowRightCircle,
        homepageIconlyLightOutlinePlay,
        homepageIconlyLightOutlineVolumeUp,
        icon,
        iconlyBoldBookmark,
        iconlyBoldCloseSquare,
        iconlyBoldDownload,
        iconlyBoldTickSquare,
        iconlyLightOutlineTimeSquare,
        pause,
        place,
        vip
      ];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/default_config_website.json
  String get defaultConfigWebsite => 'assets/jsons/default_config_website.json';

  /// List of all assets
  List<String> get values => [defaultConfigWebsite];
}

class $AssetsRivesGen {
  const $AssetsRivesGen();

  /// File path: assets/rives/bgr_catbot.riv
  RiveGenImage get bgrCatbot =>
      const RiveGenImage('assets/rives/bgr_catbot.riv');

  /// List of all assets
  List<RiveGenImage> get values => [bgrCatbot];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
  static const $AssetsRivesGen rives = $AssetsRivesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class RiveGenImage {
  const RiveGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  _rive.RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    bool useArtboardSize = false,
    List<_rive.RiveAnimationController> controllers = const [],
    _rive.OnInitCallback? onInit,
  }) {
    return _rive.RiveAnimation.asset(
      _assetName,
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      useArtboardSize: useArtboardSize,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
