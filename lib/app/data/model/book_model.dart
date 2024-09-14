import 'package:audio_youtube/app/data/model/youtube_search_response.dart';

class BookModel {
  String title;
  String author;
  String img;
  String type;
  String? id;
  String? detail;
  Snippet? snippet;
  BookModel(
      {required this.title,
      required this.author,
      required this.img,
      required this.type,
      this.id,
      this.snippet,
      this.detail});
}
