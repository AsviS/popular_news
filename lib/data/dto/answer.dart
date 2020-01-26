import 'package:clean_news_ai/data/dto/article.dart';

class Answer {
  final String status;
  final int totalResults;
  final List<Article> articles;

  const Answer({
    this.status,
    this.totalResults,
    this.articles,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Answer &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          totalResults == other.totalResults &&
          articles == other.articles);

  @override
  int get hashCode => status.hashCode ^ totalResults.hashCode ^ articles.hashCode;

  Map<String, Object> toMap() {
    return {
      'status': this.status,
      'totalResults': this.totalResults,
      'articles': this.articles,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: map['articles']?.map<Article>((article) => Article.fromMap(article)).toList(),
    );
  }
}
