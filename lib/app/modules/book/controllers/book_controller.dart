import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data_test/data_test.dart';
import '../../../core/values/app_borders.dart';
import '../../../core/values/text_styles.dart';

class BookController extends GetxController {
  RxInt indext = 0.obs;
  Rx<BookModel?> bookModel = BookModel(
          title: 'Chưa có dữ liệu',
          author: 'Chưa có dữ liệu',
          img: '',
          type: '')
      .obs;
  @override
  void onInit() {
    _getArgument();
    super.onInit();
  }

  void _getArgument() {
    final data = Get.arguments as List;
    for (var e in data) {
      if (e is BookModel) {
        bookModel.value = e;
      }
    }
  }

  void tab(String tab) {
    if (tab.contains('Mô tả')) {
      indext.value = 1;
    } else {
      indext.value = 0;
    }
  }

  List<Widget> itemBuilder() {
    if (bookModel.value == null) return [_sliverNull()];

    if (bookModel.value?.type.contains(AppValues.typePlayListYoutube) == true) {
      return [];
    } else if (bookModel.value?.type.contains(AppValues.typeVideoYoutube) ==
        true) {
      return [];
    } else {
      return [];
    }
  }

  Widget _sliverNull() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Loading(),
      ),
    );
  }

  Widget _comment() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppValues.paddingLeft,
            right: AppValues.paddingRight,
            top: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppBorders.borderCardItem,
            border: const Border(
              top: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bình Luận:',
                style: headerStyle,
              ),
              5.h,
              for (var item in dataTestComments.entries)
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.key,
                        style: textStyle,
                      ),
                      Text(
                        item.value,
                        style: textStyle.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              5.h,
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Bình luận',
                    suffixIcon: Icon(Icons.send),
                    border: OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
