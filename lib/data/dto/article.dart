import 'package:clean_news_ai/data/dto/source.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  const Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });

  factory Article.fromMap(Map<String, Object> map) => Article(
        source: Source.fromMap(map['source']),
        author: map['author'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        url: map['url'] ?? '',
        urlToImage: map['urlToImage'] ?? '',
        publishedAt: map['publishedAt'] ?? '',
      );
}
