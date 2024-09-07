import 'package:audio_youtube/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookView extends GetView<BookController> {
  const BookView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: controller.itemBuilder()),
      ),
    );
  }
}
