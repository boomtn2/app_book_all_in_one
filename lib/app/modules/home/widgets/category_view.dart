import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../core/values/app_values.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;

  late TabController _tabController;

  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.paddingLeft,
          right: AppValues.paddingLeft,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleView(title: 'Thể loại'),
                TabPageSelector(
                  controller: _tabController,
                  color: Colors.blue,
                  selectedColor: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              child: PageView(
                controller: PageController(
                  initialPage: _currentPageIndex,
                ),
                children: const [
                  Text('1'),
                  Text('2'),
                  Text('3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
