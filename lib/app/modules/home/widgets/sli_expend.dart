import 'package:flutter/material.dart';

class SliverExpandedView extends StatelessWidget {
  const SliverExpandedView({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}
