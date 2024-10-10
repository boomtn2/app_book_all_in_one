class IntroPostCard {
  final String url;
  final String tile;
  final String thumb;

  factory IntroPostCard.json(Map<String, dynamic> json) {
    return IntroPostCard(
        tile: json["title"], url: json["url"], thumb: json["thumb"]);
  }

  @override
  String toString() {
    return '$tile , $url, $thumb';
  }

  IntroPostCard({required this.url, required this.tile, required this.thumb});
}

const String dataIntroPostCardJson = r"""
[
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/16",
    "title": "Tin tức trong ngày",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/02/17/vnexpress-hom-nay-1645081742.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=1pt9vKy3WBG17g-HkeLVmA"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/19",
    "title": "Điểm tin",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/05/16/diem-tin-1652654852.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=iJrP97QDFP-QkJh_NaMCeQ"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/24",
    "title": "Ly hôn",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/01/30/ly-hon-1643504712.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=hVEyuvwezxGkyWsMZoOmvQ"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/15",
    "title": "Bản ổn không?",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/02/17/ban-on-khong-1645081753.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=k1W2yJqYZlidyL0OJzBKuw"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/8",
    "title": "Thầm thì",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/03/01/tham-thi-1646109866.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=3aZaNXtUn-_w4OmSnTXlVw"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/25",
    "title": "Tôi trong gương",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/02/24/toi-trong-guong-1645669044.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=t1kDcWynBkOnqf_CPFoG5Q"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/22",
    "title": "Úp mở 18+",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/03/01/up-mo-1646109824.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=-ylzsXBDWkSiI5Le9m-jzA"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/26",
    "title": "Họ nói gì?",
    "thumb": "https://i1-vnexpress.vnecdn.net/2021/12/09/ho-noi-gi-1639045395.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=pLV6CQmJ8l7rmcw6wVr_6g"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/45",
    "title": "Tôi kể",
    "thumb": "https://i1-vnexpress.vnecdn.net/2023/07/04/toi-ke-1688455882.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=NQabUdQa2Sw8kpvc5S3fQQ"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/30/",
    "title": "Hộp đêm",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/05/16/hop-den-1652684483.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=15K4lhPyIm_wjaSqjWvwQQ"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/33/",
    "title": "Giải mã",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/08/30/giai-ma-1661875211.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=nOuB6XUhB56hzFgBABkQUA"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/18",
    "title": "Tiền để làm gì?",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/09/03/tien-lam-gi-1662199960.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=p9PF1fds21r41592hh0zVw"
  },
  {
    "url": "https://vnexpress.net/microservice/lazy-podcast/type/episodes/sid/32",
    "title": "Tài chính cá nhân",
    "thumb": "https://i1-vnexpress.vnecdn.net/2022/08/23/tai-chinh-ca-nhan-1661229701.jpg?w=180&h=180&q=100&dpr=2&fit=crop&s=Ya5509pgGazuueVZAub4sQ"
  }
]
""";
