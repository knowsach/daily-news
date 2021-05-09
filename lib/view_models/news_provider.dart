import 'dart:convert';

import 'package:tasks_status_architecture/utils/constants.dart';
import 'package:tasks_status_architecture/view_models/base_model.dart';
import 'package:http/http.dart';

class NewsProvider extends BaseModel {
  List<Article> todaysNews = [];
  // bool isLoader;
  // bool isPaginationLoader = false;
  // int page = 1;

  // operations
  String GET_DATA = 'GET_DATA';
  String MARK_FAV = 'MARK_FAV';

  Future getData({String country = 'in'}) async {
    setStatus(GET_DATA, Status.Loading);

    Response response = await get(
        '${Constants().api}country=$country&apiKey=${Constants().apiKey}');
    Map data = jsonDecode(response.body);

    data.containsKey('articles')
        ? data['articles']
            .forEach((article) => {todaysNews.add(Article.fromJson(article))})
        : todaysNews = [];

    setStatus(GET_DATA, Status.Done);
  }

  markFavNews(int index) {
    setStatus(MARK_FAV, Status.Loading);

    if (index > todaysNews.length) {
      setStatus(MARK_FAV, Status.Error);
      return;
    }
    todaysNews[index].isFav = !todaysNews[index].isFav;

    setStatus(MARK_FAV, Status.Done);
  }
}

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool isFav;

  Article() : super();

  Article.fromJson(Map<String, dynamic> json)
      : author = json.containsKey('author') && json['author'] != null
            ? json['author']
            : '',
        title = json.containsKey('title') && json['title'] != null
            ? json['title']
            : '',
        description =
            json.containsKey('description') && json['description'] != null
                ? json['description']
                : '',
        url = json.containsKey('url') && json['url'] != null ? json['url'] : '',
        urlToImage =
            json.containsKey('urlToImage') && json['urlToImage'] != null
                ? json['urlToImage']
                : '',
        isFav = false;

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'isFav': isFav
      };

// all variable keys
  final Map<String, String> modelKeyValue = {
    'desc': 'description',
    'title': 'title',
    'author': 'author',
    'site_url': 'url',
    'preview_img': 'urlToImage',
  };

  Map<String, String> getKeys() {
    return modelKeyValue;
  }
}
