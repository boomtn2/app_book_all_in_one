import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:dio/dio.dart';

import '../../model/models_export.dart';

abstract class ConfigWebsiteRemoteDataSoure {
  Future<ConfigWebsiteModel> fetchDataConfig();
}

class ConfigWebsiteRemoteDataSoureImpl extends BaseRemoteSource
    implements ConfigWebsiteRemoteDataSoure {
  final String _path =
      'https://gist.githubusercontent.com/boomtn2/51be0f26b418c4eb949c1abe12acdd55/raw/';

  @override
  Future<ConfigWebsiteModel> fetchDataConfig() async {
    var endpoint = _path;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseConfigWebsiteResponse(response));
    } catch (e) {
      final json = jsonDecode(defautConfigWebsite);
      return ConfigWebsiteModel.fromJson(json);
    }
  }

  ConfigWebsiteModel _parseConfigWebsiteResponse(Response<dynamic> response) {
    String data = response.data;
    final json = jsonDecode(data);

    return ConfigWebsiteModel.fromJson(json);
  }
}

String defautConfigWebsite = """
{
  "config-website": [
    {
      "type": "wiki",
      "website": "https://truyenwikidich.net",
      "listbookhtml": {
        "querryList": "div.book-list div.book-item",
        "queryText": "a.tooltipped",
        "queryScr": "img",
        "queryAuthor": "a.truncate",
        "queryview": "p.book-stats-box",
        "queryHref": "a.tooltipped"
      },
      "chapterhtml": {
        "querryLinkNext": "#btnNextChapter",
        "querryLinkPre": "#btnPreChapter",
        "querryTextChapter": "#bookContentBody",
        "querryTitle": "span.top-title"
      },
      "jsleak": {
        "jsIndexing": " var liElements = document.querySelectorAll('div.volume-list ul.pagination li');   var paginationData = [];   liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');      if (anchorElement) {                      var textContent = anchorElement.textContent.trim();                  var liClasses = liElement.className;          var liItem = {               \"textContent\": textContent,                          \"liClasses\": liClasses         };          paginationData.push(liItem);     } });   var jsonData = JSON.stringify(paginationData);  jsonData;",
        "jsListChapter": "var liElements = document.querySelectorAll('li.chapter-name');   var liData = [];   liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');         if (anchorElement) {         var href = anchorElement.getAttribute('href');         var textContent = anchorElement.textContent.trim();                 var liItem = {             \"href\": 'https://wikisach.net/'+href,             \"textContent\": textContent         };                liData.push(liItem);     } });   var jsonData = JSON.stringify(liData); jsonData;",
        "jsActionNext": "var father = document.querySelector('ul.pagination'); var aElements = father.querySelectorAll('a[data-action=\"loadBookIndex\"]');         aElements.forEach(function(aElement) {           if (aElement.textContent.trim() === '?') {             aElement.click();           }         });",
        "jsDescription": "document.querySelector('div.book-desc-detail').textContent;",
        "jsCategory": "var liElement = document.querySelector('.book-desc p');    var liData = [];         var anchorElement = liElement.querySelectorAll('a'); anchorElement.forEach(function(liElement) {         if (anchorElement) {         var href = liElement.getAttribute('href');         var textContent = liElement.textContent.trim();               var liItem = {             \"href\": 'https://wikisach.net/'+href,             \"textContent\": textContent         };                  liData.push(liItem);     } });    var jsonData = JSON.stringify(liData); jsonData;",
        "jsOther": ""
      }
    },
    {
      "type": "dtruyen",
      "website": "https://dtruyen.com/",
      "listbookhtml": {
        "querryList": "ul li.story-list",
        "queryText": "h3.title",
        "queryScr": "img.cover",
        "queryAuthor": "p[itemprop=\"author\"]",
        "queryview": "",
        "queryHref": "a.thumb"
      },
      "chapterhtml": {
        "querryLinkNext": "a[title=\"Chương Sau\"]",
        "querryLinkPre": "a[title=\"Chương Trước\"]",
        "querryTextChapter": "#chapter-content",
        "querryTitle": "h2.chapter-title"
      },
      "jsleak": {
        "jsIndexing": "var liElements = document.querySelectorAll('#chapters div.pagination-control ul.pagination li'); var paginationData = []; liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');     if (anchorElement) {         var textContent = anchorElement.textContent.trim();         var liClasses = liElement.className;         var liItem = {             \"textContent\": textContent,             \"liClasses\": liClasses         };         paginationData.push(liItem);     } }); var jsonData = JSON.stringify(paginationData); jsonData;",
        "jsListChapter": "var liElements = document.querySelectorAll('#chapters li.vip-0'); var liData = []; liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');     if (anchorElement) {         var href = anchorElement.getAttribute('href');         var textContent = anchorElement.textContent.trim();         var liItem = {              \"href\": href,             \"textContent\": textContent         };         liData.push(liItem);     } }); var jsonData = JSON.stringify(liData); jsonData;",
        "jsActionNext": "var father = document.querySelector('ul.pagination'); var aElements = father.querySelectorAll('a'); aElements.forEach(function(aElement) {     if (aElement.textContent.trim() === '?') {         aElement.click();     } });",
        "jsDescription": "document.querySelector('div.description').textContent;",
        "jsCategory": "var liElement = document.querySelector('p.story_categories'); var liData = []; var anchorElement = liElement.querySelectorAll('a'); anchorElement.forEach(function(liElement) {     if (anchorElement) {         var href = liElement.getAttribute('href');         var textContent = liElement.textContent.trim();         var liItem = {              \"href\": href,             \"textContent\": textContent         };         liData.push(liItem);     } }); var jsonData = JSON.stringify(liData); jsonData;",
        "jsOther": ""
      }
    },
    {
      "type": "hotruyen",
      "website": "https://hotruyen1.com/",
      "listbookhtml": {
        "querryList": "div.sitem",
        "queryText": "div.title",
        "queryScr": "img.lazy",
        "queryAuthor": "div.author",
        "queryview": "div.type",
        "queryHref": "div.title a"
      },
      "chapterhtml": {
        "querryLinkNext": "#chcontent > div.botchnav > a:nth-child(3)",
        "querryLinkPre": "#chcontent > div.botchnav > a:nth-child(1)",
        "querryTextChapter": "#borderchapter",
        "querryTitle": "h2.chapter-title"
      },
      "jsleak": {
        "jsIndexing": "var liElements = document.querySelectorAll('#chapters div.pagination-control ul.pagination li'); var paginationData = []; liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');     if (anchorElement) {         var textContent = anchorElement.textContent.trim();         var liClasses = liElement.className;         var liItem = {             \"textContent\": textContent,             \"liClasses\": liClasses         };         paginationData.push(liItem);     } }); var jsonData = JSON.stringify(paginationData); jsonData;",
        "jsListChapter": " var liElements = document.querySelectorAll('div.chapter');   var liData = [];   liElements.forEach(function(liElement) {     var anchorElement = liElement.querySelector('a');         if (anchorElement) {         var href = anchorElement.getAttribute('href');         var textContent = anchorElement.textContent.trim();                 var liItem = {             \"href\": 'https://hotruyen1.com/'+href,             \"textContent\": textContent         };                liData.push(liItem);     } });   var jsonData = JSON.stringify(liData); jsonData;",
        "jsActionNext": "var father = document.querySelector('ul.pagination'); var aElements = father.querySelectorAll('a'); aElements.forEach(function(aElement) {     if (aElement.textContent.trim() === '?') {         aElement.click();     } });",
        "jsDescription": "document.querySelector('#newchap #des-info').textContent;",
        "jsCategory": "var liElement = document.querySelector('div.btags'); var liData = []; var anchorElement = liElement.querySelectorAll('a'); anchorElement.forEach(function(liElement) {     if (anchorElement) {         var href = liElement.getAttribute('href');         var textContent = liElement.textContent.trim();         var liItem = {              \"href\": href,             \"textContent\": textContent         };         liData.push(liItem);     } }); var jsonData = JSON.stringify(liData); jsonData;",
        "jsOther": "document.querySelector('#pageview > div:nth-child(1) > div > div > div.dinfo > div:nth-child(7) > a').click();"
      }
    }
  ]
}
""";
