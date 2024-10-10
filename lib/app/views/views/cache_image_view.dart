import 'package:audio_youtube/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/utils/util.dart';

class CacheImage extends GetView {
  const CacheImage({
    this.url,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  });
  final String? url;
  final BorderRadius? borderRadius;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Util.imageOk(url ?? '')
        ? ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child: CachedNetworkImage(
              imageUrl: url ?? '',
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(child: loadingWidget),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: width,
              height: height,
              fit: BoxFit.fill,
            ),
          )
        : ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child: Assets.images.avt.image(
              width: width,
              height: height,
              fit: BoxFit.fill,
            ));
  }
}

const loadingWidget = LoadingWidget(
  isImage: true,
);

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.blueAccent;
    return Center(
      child: isImage
          ? const SpinKitRipple(color: color)
          : const SpinKitWave(color: color),
    );
  }
}
