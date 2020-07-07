import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:clean_news_ai/features/news/presentation/presenter/news_screen_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osam_flutter/osam_flutter.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = context.presenter<NewsScreenPresenter>();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Material(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  await presenter.updateNews();
                },
              ),
              ValueListenableBuilder<List<NewsArticle>>(
                valueListenable: presenter.news,
                builder: (_, news, __) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final newsArticle = news[index];
                      return GestureDetector(
                        onTap: () => presenter.showImage(newsArticle),
                        child: Card(
                            color: Colors.black87,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  // hero
                                  child: Image.network(
                                    newsArticle.urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    newsArticle.title,
                                    style: TextStyle(color: Colors.amber, fontSize: 20),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }, childCount: news.length),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
