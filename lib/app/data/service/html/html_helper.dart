import 'package:audio_youtube/app/core/const.dart';
import 'package:dio/dio.dart';

import 'package:html/parser.dart' as parserhtml;
import 'package:html/dom.dart' as dom;

import '../../model/book_model.dart';

class HTMLHelper {
  List<BookModel> getListBookHtml(
      {required Response response,
      required String querryList,
      required String queryText,
      required String queryAuthor,
      required String queryview,
      required String queryScr,
      required String queryHref,
      required String domain}) {
    List<BookModel> listBook = [];
    try {
      if (response.statusCode == 200) {
        dom.Document document = parserhtml.parse(response.data);
        final listBookHTML = document.querySelectorAll(querryList);

        // hạn chế xử dụng class có dấu cách
        for (var element in listBookHTML) {
          listBook.add(getBookHtml(
              element: element,
              queryText: queryText,
              queryAuthor: queryAuthor,
              queryview: queryview,
              queryScr: queryScr,
              queryHref: queryHref,
              domain: domain));
        }
      }
    } catch (e) {
      showLog('[ERROR] getListBookHtml error {$e}');
    }

    return listBook;
  }

  BookModel getBookHtml(
      {required dom.Element element,
      required String queryText,
      required String queryview,
      required String queryAuthor,
      required String queryScr,
      required String queryHref,
      required String domain}) {
    String title = getTextHTML(element, queryText);
    String view = getTextHTML(element, queryview);
    String tacGia = getTextHTML(element, queryAuthor);
    String img = getScrHTML(element, queryScr);
    String link = getHrefHTML(element, queryHref);

    img = addDomainToLink(img, domain);
    link = addDomainToLink(link, domain);

    final book = BookModel(
      img: img,
      id: link,
      title: title,
      author: tacGia,
      type: Const.typeText,
      view: view,
      status: '',
      detail: '',
      category: '',
    );
    // showLog('[SUCCES] getBookHtml :{${book.toMapFullOption()}}');
    return book;
  }

  BookModel getInforHtml(
      {required Response response,
      required String queryText,
      required String queryDetail,
      required String queryCategory,
      required String queryStatus,
      required String queryview,
      required String queryAuthor,
      required String queryScr,
      required String queryHref,
      required String domain}) {
    try {
      if (response.statusCode == 200) {
        dom.Document document = parserhtml.parse(response.data);
        final element = document.querySelector("*");
        if (element != null) {
          String title = getTextHTML(element, queryText);
          String detail = getTextHTML(element, queryDetail);
          String status = getTextHTML(element, queryStatus);
          String category = getTextHTML(element, queryCategory);
          String view = getTextHTML(element, queryview);
          String tacGia = getTextHTML(element, queryAuthor);
          String img = getScrHTML(element, queryScr);
          String link = getHrefHTML(element, queryHref);
          img = addDomainToLink(img, domain);
          link = addDomainToLink(link, domain);

          final book = BookModel(
            img: img,
            id: link,
            title: title,
            author: tacGia,
            type: Const.typeText,
            view: view,
            status: status,
            detail: detail,
            category: category,
          );
          // showLog('[SUCCES] getBookHtml :{${book.toMapFullOption()}}');
          return book;
        }
      }
    } catch (e) {
      showLog('[ERROR] getListBookHtml error {$e}');
    }

    return BookModel(title: '', author: '', img: '', type: '');
  }

  ChapterModel getChapter({
    required Response response,
    required String querryTextChapter,
    required String querryLinkNext,
    required String querryLinkPre,
    required String querryTitle,
    required String linkChapter,
    required String domain,
  }) {
    ChapterModel chapter = ChapterModel.none();
    try {
      if (response.statusCode == 200) {
        dom.Document document = parserhtml.parse(response.data);
        final element = document.querySelector('*');
        if (element != null) {
          String textChapter = getTextHTML(element, querryTextChapter);
          String title = getTextHTML(element, querryTitle);
          String linkNext = getHrefHTML(element, querryLinkNext);
          String linkPre = getHrefHTML(element, querryLinkPre);

          linkNext = addDomainToLink(linkNext, domain);
          linkPre = addDomainToLink(linkPre, domain);

          return ChapterModel(
              text: textChapter,
              title: title,
              linkChapter: linkChapter,
              linkNext: linkNext,
              linkPre: linkPre);
        }
      }
    } catch (e) {
      showLog('[ERROR] getListBookHtml error {$e}');
    }

    return chapter;
  }

  String addDomainToLink(String link, String domain) {
    if (link.isNotEmpty && link.contains('null') == false) {
      if (link.startsWith('http')) {
        // Nếu liên kết đã chứa đầy đủ domain, không cần thêm
        return link;
      } else if (link.startsWith('/')) {
        // Nếu liên kết bắt đầu bằng "/", thêm domain vào đầu liên kết
        return domain + link;
      } else {
        // Nếu liên kết không bắt đầu bằng "/", thêm "/" và domain vào đầu liên kết
        return '$domain/$link';
      }
    } else {
      return '';
    }
  }

  String getTextHTML(dom.Element element, String query) {
    try {
      final item = element.querySelector(query);

      if (item == null) {
        return '';
      } else {
        return item.text.trim();
      }
    } catch (e) {
      showLog('[ERROR] getTextHTML error {$e}');
      return '';
    }
  }

  String getScrHTML(dom.Element element, String query) {
    try {
      final item = element.querySelector(query);

      if (item == null) {
        return '';
      } else {
        String link = '${item.attributes['src']}';
        if (link.isEmpty) {
          return '${item.attributes['data-layzr']}';
        }
        return link;
      }
    } catch (e) {
      showLog('[ERROR] getScrHTML   {$e}');
      return '';
    }
  }

  String getHrefHTML(dom.Element element, String query) {
    try {
      final item = element.querySelector(query);

      if (item == null) {
        return '';
      } else {
        return '${item.attributes['href']}';
      }
    } catch (e) {
      showLog('[ERROR] getHrefHTML  {$e}');
      return '';
    }
  }

  void showLog(String mess) {
    // debugPrint('[HTML CONVERT] ${mess}');
  }
}
