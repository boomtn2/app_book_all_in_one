import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/audio_controller.dart';

class AudioView extends GetView<AudioController> {
  const AudioView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AudioView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
