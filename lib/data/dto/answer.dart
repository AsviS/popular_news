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

  factory Answer.fromMap(Map<String, dynamic> map) => Answer(
        status: map['status'] ?? '',
        articles: map['articles']?.map<Article>((article) => Article.fromMap(article))?.toList() ??
            <Article>[],
      );
}
