part of '../use_cases/news_usecase.dart';

@HiveType(typeId: hiveId.newsScope)
class NewsScope {
  @HiveField(0)
  PropertyNotifier<List<NewsArticle>> _news;
  IProperty<List<NewsArticle>> get news => _news;

  NewsScope([this._news]) {
    _news ??= PropertyNotifier<List<NewsArticle>>([]);
  }

  void _fetchNewNews(List<NewsArticle> newNews) => _news.update((value) => value
    ..clear()
    ..addAll(newNews));
}
