import 'dart:convert';

import 'package:tasks_status_architecture/utils/constants.dart';
import 'package:tasks_status_architecture/view_models/base_model.dart';
import 'package:http/http.dart';

class NewsProvider extends BaseModel {
  List<Article> todaysNews = [];

  // operations
  String GET_DATA = 'get_data';
  String LIKE_ARTICLE = 'like_article';

  Future getNewsData({String country = 'in'}) async {
    setStatus(GET_DATA, Status.Loading);
    try {
      Response response = await get(
          '${Constants().api}country=$country&apiKey=${Constants().apiKey}');
      Map data = jsonDecode(response.body);

      data.containsKey('articles')
          ? data['articles']
              .forEach((article) => {todaysNews.add(Article.fromJson(article))})
          : todaysNews = [];

      setData(GET_DATA, todaysNews);
      setStatus(GET_DATA, Status.Done);
    } catch (e) {
      setError(GET_DATA, e.toString());
      setStatus(GET_DATA, Status.Error);
    }
  }

  likeNewsArticle(int index) async {
    setStatus(LIKE_ARTICLE, Status.Loading);
    await Future.delayed(Duration(seconds: 1));

    if (index > todaysNews.length) {
      setStatus(LIKE_ARTICLE, Status.Error);
      setError(LIKE_ARTICLE, 'index not in range');
      return;
    }
    todaysNews[index].isFav = !todaysNews[index].isFav;

    setStatus(LIKE_ARTICLE, Status.Done);
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
}
