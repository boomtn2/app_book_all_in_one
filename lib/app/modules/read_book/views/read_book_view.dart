import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/read_book_controller.dart';

class ReadBookView extends GetView<ReadBookController> {
  const ReadBookView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadBookView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReadBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
