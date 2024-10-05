import 'package:audio_youtube/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  const BookView(this.instanceController, {super.key});
  static const name = "book";
  final BookController instanceController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            CustomScrollView(slivers: instanceController.itemBuilder(context)),
      ),
    );
  }
}
