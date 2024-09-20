import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/repository/data_repository.dart';
import '../../views/navigator/navigator.dart';

class RootApp extends StatelessWidget {
  final Widget child;
  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
          body: SlidingUpPanel(
            maxHeight: MediaQuery.sizeOf(context).height,
            minHeight: 60,
            parallaxEnabled: true,
            parallaxOffset: .5,
            controller: DataRepository.instance.panelController,
            defaultPanelState: PanelState.CLOSED,
            body: child,
            onPanelClosed: () {},
            onPanelOpened: () {
              //show full
            },
            onPanelSlide: (position) {
              // print('onPanelSlide');
            },
            isDraggable: true,
            collapsed: Container(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.72),
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.w,
                  IconButton(
                      onPressed: () {
                        // controller.closedPannel();
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      )),
                  20.w,
                ],
              ),
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panel: Container(),
          ),
          bottomNavigationBar: const AppNavigationBar()),
    );
  }
}
