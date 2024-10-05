import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/text_styles.dart';
import '../controllers/home_controller.dart';
import 'title.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TitleView(
                    title: 'Đời sống tâm sự',
                    style: bigTitleStyle.s20,
                    funtion: () {},
                  ),
                  for (int i = 0; i < controller.newsListBook.length; ++i)
                    InkWell(
                      onTap: () => controller.openDetail(
                          controller.newsListBook[i], context),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              CacheImage(
                                url: controller.newsListBook[i].img,
                                height: 80,
                                width: 50,
                              ),
                              Expanded(
                                  child: Text(controller.newsListBook[i].title))
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
