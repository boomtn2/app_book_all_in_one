import 'package:audio_youtube/app/modules/audio/controllers/audio_controller.dart';
import 'package:audio_youtube/app/modules/audio/views/mini_audio_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../data/repository/data_repository.dart';
import '../../views/navigator/navigator.dart';
import '../audio/views/audio_view.dart';

class RootApp extends StatelessWidget {
  final Widget child;
  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AudioController>(
            init: AudioController(context),
            dispose: (state) {
              Get.delete<AudioController>();
            },
            builder: (controller) {
              return SlidingUpPanel(
                  maxHeight: MediaQuery.sizeOf(context).height,
                  minHeight: 60,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  controller: DataRepository.instance.panelController,
                  defaultPanelState: PanelState.CLOSED,
                  body: child,
                  onPanelClosed: () {
                    controller.showAppBar.value = false;
                  },
                  onPanelOpened: () {
                    controller.showAppBar.value = true;
                    //show full
                  },
                  onPanelSlide: (position) {
                    // print('onPanelSlide');
                  },
                  isDraggable: true,
                  collapsed: MiniAudioView(instanceController: controller),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  panel: AudioView(controller));
            }),
        bottomNavigationBar: const AppNavigationBar());
  }
}
