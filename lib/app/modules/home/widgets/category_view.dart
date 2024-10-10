import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/category_model.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_values.dart';
import 'sli_expend.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;

  late TabController _tabController;

  final int _currentPageIndex = 0;

  final controller = Get.find<HomeController>();
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
    final size = MediaQuery.sizeOf(context);

    return Obx(
      () => controller.tags.isEmpty
          ? const SliverExpandedView(height: 0)
          : SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppValues.paddingLeft,
                  right: AppValues.paddingLeft,
                ),
                child: Obx(
                  () => Column(
                    children: [
                      TitleView(
                        title: 'Thể loại',
                        child: TabPageSelector(
                          controller: _tabController,
                          color: Colors.blue,
                          selectedColor: Colors.black,
                        ),
                        funtion: () => controller.loadMoreCategory(context),
                      ),
                      SizedBox(
                        height: 100,
                        width: size.width,
                        child: PageView(
                          onPageChanged: (value) {
                            setState(() {
                              _tabController.animateTo(value);
                            });
                          },
                          controller: PageController(
                            initialPage: _currentPageIndex,
                          ),
                          children: [
                            for (int i = 0; i < controller.tags.length / 4; ++i)
                              _page(
                                Size(size.width, 100),
                                controller.tags.getNullIndex((i * 4)),
                                controller.tags.getNullIndex((i * 4) + 1),
                                controller.tags.getNullIndex((i * 4) + 2),
                                controller.tags.getNullIndex((i * 4) + 3),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _page(Size size, Tag? tag1, Tag? tag2, Tag? tag3, Tag? tag4) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              _item(tag1),
              10.w,
              _item(tag2),
            ],
          ),
          5.h,
          Row(
            children: [_item(tag3), 10.w, _item(tag4)],
          ),
        ],
      ),
    );
  }

  Widget _item(Tag? tag) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              tag?.name ?? '',
              style: afaca.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
