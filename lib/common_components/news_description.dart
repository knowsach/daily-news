import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/common_components/news_card.dart';
import 'package:tasks_status_architecture/view_models/news_provider.dart';

class NewsDescription extends StatelessWidget {
  Article article = new Article();
  NewsDescription({this.article});
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NewsCard(article, isNewsDesc: true),
    );
  }
}
