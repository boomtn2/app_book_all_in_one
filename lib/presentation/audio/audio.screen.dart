import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/audio.controller.dart';

class AudioScreen extends GetView<AudioController> {
  const AudioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AudioScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
