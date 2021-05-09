import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/common_components/news_card.dart';
import 'package:tasks_status_architecture/common_components/provider_handler.dart';
import 'package:tasks_status_architecture/view_models/news_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Today\'s News'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.new_releases)),
                Tab(child: Icon(Icons.favorite)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Container(
              //     child: data.isLoader ? Loader('splash') : newsFeeds(data, false))

              ProviderHandler<NewsProvider>(
                key: UniqueKey(),
                functionName: NewsProvider().GET_DATA,
                showError: false,
                load: (provider) => provider.getData(),
                loaderBuilder: (provider) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (provider) {
                  return Center(
                      child: Container(child: Text('Something went wrong...')));
                },
                successBuilder: (provider) {
                  return ListView.builder(
                    itemCount: provider.todaysNews.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          NewsCard(provider.todaysNews[index],
                              index: index, isNewsDesc: false),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newsCard(List<Article> allNewsData) {
    final ScrollController _listScrollController = ScrollController();

    return ListView.builder(
      controller: _listScrollController,
      itemCount: allNewsData.length,
      itemBuilder: (context, index) {
        print('in list view');
        return Column(
          children: [
            NewsCard(allNewsData[index], index: index, isNewsDesc: false),
          ],
        );
      },
    );
  }
}
