import 'dart:convert';

class PodcastList {
  final List<Podcast> rss;

  PodcastList({required this.rss});

  factory PodcastList.fromJson(Map<String, dynamic> json) {
    List<Podcast> rssList = [];
    json['rss'].forEach((e) => rssList.add(Podcast.fromMap(e)));
    return PodcastList(rss: rssList);
  }

  Map<String, dynamic> toJson() {
    return {
      'rss': rss.map((podcast) => podcast.toJson()).toList(),
    };
  }
}

class Podcast {
  final String name;
  final String link;
  final String img;
  int price = 1000;

  Podcast(
      {required this.name,
      required this.link,
      required this.img,
      required String price}) {
    this.price = parseInt(price) ?? 1000;
  }

  Podcast copyWith({
    String? name,
    String? link,
    String? img,
    String? price,
  }) {
    return Podcast(
      name: name ?? this.name,
      link: link ?? this.link,
      img: img ?? this.img,
      price: price ?? this.price.toString(),
    );
  }

  int? parseInt(String? intString) {
    if (intString == null) {
      return null;
    }
    return int.tryParse(intString);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'link': link,
      'img': img,
      'price': price,
    };
  }

  factory Podcast.fromMap(Map<String, dynamic> map) {
    try {
      return Podcast(
        name: map['name'] as String,
        link: map['link'] as String,
        img: map['img'] as String,
        price: map['price'] as String,
      );
    } catch (e) {
      return Podcast.none();
    }
  }

  factory Podcast.none() => Podcast(img: '', link: '', name: '', price: '');

  String toJson() => json.encode(toMap());

  factory Podcast.fromJson(String source) =>
      Podcast.fromMap(json.decode(source) as Map<String, dynamic>);
}
