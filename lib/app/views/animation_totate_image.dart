import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';

import '../data/repository/data_repository.dart';

class RotateImage extends StatefulWidget {
  const RotateImage({super.key, required this.voiCallback, required this.url});
  final Function voiCallback;
  final String url;
  @override
  _RotateImageState createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    // Tạo AnimationController để quản lý vòng đời của hoạt ảnh
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    ); // Lặp lại liên tục
    animation = Tween<double>(begin: 0, end: 360).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    DataRepository.instance.animationController = _controller;
  }

  @override
  void dispose() {
    // Hủy controller khi Widget bị hủy để tránh memory leak
    _controller.dispose();
    DataRepository.instance.animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value *
              (3.1415927 / 180), // chuyển đổi giá trị thành radian
          child: child,
        );
      },
      child: CacheImage(
        url: widget.url,
        borderRadius: BorderRadius.circular(250),
        height: 250,
        width: 250,
      ),
    );
  }
}
