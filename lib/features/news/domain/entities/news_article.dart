part of '../use_cases/news_usecase.dart';

@HiveType(typeId: hiveId.newsArticle)
class NewsArticle {
  @HiveField(0)
  final String source;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String urlToImage;
  @HiveField(6)
  final String publishedAt;
  @HiveField(7)
  PropertyNotifier<bool> _isSaved;

  IProperty<bool> get isSaved => _isSaved;

  NewsArticle(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      PropertyNotifier<bool> isSaved}) {
    _isSaved = isSaved ?? PropertyNotifier<bool>(false);
    // possible chaining here
  }
}
