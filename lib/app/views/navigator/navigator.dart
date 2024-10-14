import 'dart:ui';

import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

const double navigationPanelHeight = 55;

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.callBack});
  final Function(int) callBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: navigationPanelHeight,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: CurvedNavigationBar(
            backgroundColor:
                theme.colorScheme.secondaryContainer.withOpacity(0.72),
            buttonBackgroundColor: theme.colorScheme.inversePrimary,
            color: theme.colorScheme.surface,
            height: navigationPanelHeight,
            animationDuration: const Duration(milliseconds: 350),
            items: const [
              Icon(
                AppIcons.naviHome,
                size: 18,
              ),
              Icon(AppIcons.appSearch, size: 18),
              Icon(AppIcons.appRank, size: 18),
              Icon(AppIcons.naviAccount, size: 18)
            ],
            index: 0,
            onTap: (i) {
              callBack(i);
            },
          ),
        ),
      ),
    );
  }
}
