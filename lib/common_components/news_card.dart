import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/common_components/loading.dart';
import 'package:tasks_status_architecture/common_components/news_description.dart';
import 'package:tasks_status_architecture/common_components/provider_callback.dart';
import 'package:tasks_status_architecture/view_models/news_provider.dart';

class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();

  final Article article;
  final int index;
  final bool isNewsDesc;
  NewsCard(this.article, {this.index, this.isNewsDesc});
}

class _NewsCardState extends State<NewsCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isNewsDesc) {
          Navigator.of(context).push(PageRouteBuilder(
            fullscreenDialog: true,
            transitionDuration: Duration(milliseconds: 900),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return NewsDescription(article: widget.article);
            },
          ));
        }
      },
      child: Stack(children: [
        Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                new BoxShadow(color: Color(0xFFdee2e6), blurRadius: 20),
              ]),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(
                children: [
                  Container(
                    child: widget.article.urlToImage != null
                        ? Hero(
                            tag: widget.article.urlToImage,
                            child: Image.network(
                              widget.article.urlToImage,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 200,
                              loadingBuilder: (context, child, progress) {
                                return progress != null
                                    ? Center(
                                        child: Loader('image_load'),
                                      )
                                    : child;
                              },
                            ),
                          )
                        : Image.network(
                            'https://image.shutterstock.com/image-vector/breaking-news-background-planet-600w-667420906.jpg',
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.article.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                  SizedBox(height: 10),
                  Container(
                    child: widget.isNewsDesc
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget.article.description,
                                style: TextStyle(
                                  fontSize: 18,
                                )))
                        : Container(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: widget.isNewsDesc
                        ? RaisedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/webView',
                                  arguments: {'url': widget.article.url});
                            },
                            color: Colors.amber[600],
                            child: Text('Read more'),
                          )
                        : Container(),
                  ),
                  Container(
                    child: !widget.isNewsDesc
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await providerCallback<NewsProvider>(
                                          context,
                                          load: (provider) => provider
                                              .likeNewsArticle(widget.index),
                                          taskName: (provider) =>
                                              provider.LIKE_ARTICLE,
                                          showLoader: true,
                                          showDialog: true,
                                          onErrorHandeling: (provider) {
                                            print(
                                                'error: ${provider.error[provider.LIKE_ARTICLE]}');
                                          },
                                          onSuccess: (provider) {
                                            print('article updated');
                                          });
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color(widget.article.isFav
                                          ? 0xFFcc2900
                                          : 0xFF808080),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      widget.article.author != ''
                                          ? '-${widget.article.author}'
                                          : '-Anonymous',
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
