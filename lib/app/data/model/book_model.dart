import 'dart:convert';
import 'package:audio_youtube/app/data/model/youtube_search_response.dart';

class BookModel {
  String title;
  String author;
  String img;
  String type;
  String? id;
  String? detail;
  String? status;
  String? category;
  String? view;
  Snippet? snippet;
  int? price;

  BookModel(
      {required this.title,
      required this.author,
      required this.img,
      required this.type,
      this.id,
      this.snippet,
      this.detail,
      this.status,
      this.category,
      this.view,
      this.price});

  ChapterModel getChapterModel() {
    return ChapterModel(
      text: '',
      title: title,
      linkChapter: id ?? '',
      linkNext: '',
      linkPre: '',
    );
  }
}

class ChapterModel {
  String text;
  String title;
  String linkChapter;
  String linkNext;
  String linkPre;
  ChapterModel({
    required this.text,
    required this.title,
    required this.linkChapter,
    required this.linkNext,
    required this.linkPre,
  });

  factory ChapterModel.none() {
    return ChapterModel(
        text: '', title: '', linkChapter: '', linkNext: '', linkPre: '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'title': title,
      'linkChapter': linkChapter,
      'linkNext': linkNext,
      'linkPre': linkPre,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      text: map['text'] as String,
      title: map['title'] as String,
      linkChapter: map['linkChapter'] as String,
      linkNext: map['linkNext'] as String,
      linkPre: map['linkPre'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModel.fromJson(String source) =>
      ChapterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chapter(text: $text, title: $title, linkChapter: $linkChapter, linkNext: $linkNext, linkPre: $linkPre)';
  }
}
