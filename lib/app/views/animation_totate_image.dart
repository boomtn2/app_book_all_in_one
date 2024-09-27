import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  const RotateImage({super.key, required this.voiCallback});
  final Function voiCallback;
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
  }

  @override
  void dispose() {
    // Hủy controller khi Widget bị hủy để tránh memory leak
    _controller?.dispose();
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(250),
          child: Image.network(
              'https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_nologo/41896373/41896373-1724601284722-56b76668e93f1.jpg'),
        ));
  }
}
