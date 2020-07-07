import 'package:clean_news_ai/features/news/domain/entities/request.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> news(Request request);
}
