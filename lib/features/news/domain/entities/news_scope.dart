import 'package:clean_news_ai/app/hive_ids.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'news_article.dart';

part 'news_scope.g.dart';

@HiveType(typeId: HiveId.newsScope)
class NewsScope extends PropertyChanger {
  @HiveField(0)
  final IProperty<List<NewsArticle>> news;

  void updateNews(List<NewsArticle> newNews) => let(news).apply((value) => value
    ..clear()
    ..addAll(newNews));

  NewsScope({IProperty<List<NewsArticle>> news}) : news = news ?? IProperty(<NewsArticle>[]);
}
