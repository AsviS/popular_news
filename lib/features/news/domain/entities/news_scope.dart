part of '../use_cases/news_usecase.dart';

@HiveType(typeId: HiveId.newsScope)
class NewsScope with PropertyChanger {
  @HiveField(0)
  final IProperty<List<NewsArticle>> news;
  NewsScope({IProperty<List<NewsArticle>> news}) : news = news ?? IProperty(<NewsArticle>[]);

  void _fetchNewNews(List<NewsArticle> newNews) => updateValue(
      news,
      (value) => value
        ..clear()
        ..addAll(newNews));
}
