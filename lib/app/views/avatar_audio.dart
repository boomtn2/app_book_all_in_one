import 'package:flutter/material.dart';

import 'animation_totate_image.dart';

class AvatarAudio extends StatelessWidget {
  const AvatarAudio({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          gradient: const RadialGradient(
            center: Alignment(0.7, -0.6), // near the top right
            radius: 0.2,
            colors: <Color>[
              Colors.grey, // yellow sun
              Colors.white, // blue sky
            ],
            stops: <double>[0.4, 1.0],
          ),
          borderRadius: BorderRadius.circular(250),
          border:
              const Border(bottom: BorderSide(color: Colors.grey, width: 2))),
      child: Stack(
        children: [
          RotateImage(
            voiCallback: () {},
            url: url,
          ),
          Center(
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey, width: 2)),
            ),
          )
        ],
      ),
    );
  }
}
