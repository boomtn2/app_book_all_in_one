import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/models_export.dart';
import 'package:audio_youtube/app/modules/home/widgets/sli_expend.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchBookController> {
  const SearchView({super.key});
  static const String name = 'search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SearchView'),
          centerTitle: true,
        ),
        body: Obx(
          () => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppValues.paddingLeft,
                      right: AppValues.paddingRight),
                  child: Wrap(
                    spacing: 10,
                    children: controller.tagSelected.keys
                        .map(
                          (e) => Text(
                            e.toString(),
                            style: afaca,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: IconButton(
                    onPressed: () {
                      controller.search(context);
                    },
                    icon: const Icon(Icons.search)),
              ),
              const SliverExpandedView(height: 20),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppValues.paddingLeft,
                      right: AppValues.paddingRight),
                  child: Row(
                    children: [
                      const Expanded(child: Divider()),
                      Text(
                        'Thể loại'.toString(),
                        style: titleStyle,
                      ),
                      const Expanded(child: Divider())
                    ],
                  ),
                ),
              ),
              const SliverExpandedView(height: 10),
              for (var item in controller.grTag)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppValues.paddingLeft,
                        right: AppValues.paddingRight),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item.nameGroup,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        Wrap(
                          children: item.tags
                              .map(
                                (element) => _itemTagWidget(element),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: 80.h,
              )
            ],
          ),
        ));
  }

  Widget _itemName(String name, bool select, {bool isSearch = false}) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: select,
            groupValue: true,
            onChanged: null,
          ),
          5.w,
          isSearch ? const Icon(Icons.search) : const SizedBox.shrink(),
          Text(
            name,
            style: afaca,
          ),
        ],
      ),
    );
  }

  Widget _itemTagWidget(Tag tag) {
    return InkWell(
      onTap: () {
        controller.selectTag(tag);
      },
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              value: tag,
              groupValue: controller.tagSelected[tag.name],
              onChanged: null,
            ),
            5.w,
            Text(
              tag.name,
              style: afaca,
            ),
          ],
        ),
      ),
    );
  }
}
