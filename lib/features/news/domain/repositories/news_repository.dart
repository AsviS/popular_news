import 'package:clean_news_ai/features/news/domain/entities/news_article.dart';
import 'package:clean_news_ai/features/news/domain/entities/request.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class NewsRepository {
  Cancelable<List<NewsArticle>> news(Request request);
}
