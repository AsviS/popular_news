import 'package:clean_news_ai/features/news/data/data_sources/news_api.dart';
import 'package:clean_news_ai/features/news/data/models/article.dart';
import 'package:clean_news_ai/features/news/domain/entities/request.dart';
import 'package:clean_news_ai/features/news/domain/repositories/news_repository.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:worker_manager/worker_manager.dart';

const apiKeys = [
  '10d15b867c564e6ba33531af21905fb2',
];

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi api;

  NewsRepositoryImpl(this.api);

  @override
  Cancelable<List<NewsArticle>> news(Request request) => Executor()
      .execute(arg1: api, arg2: request, arg3: apiKeys.first, fun3: _news)
      .next((value) => value
          .map((e) => NewsArticle(e.source?.name ?? '', e.author ?? '', e.title ?? '',
              e.description ?? '', e.url ?? '', e.urlToImage ?? '', e.publishedAt ?? ''))
          .toList());

  static Future<List<Article>> _news(NewsApi api, Request request, String apiKey) async {
    final answer = await api.news(
        category: request.category, country: request.country, page: request.page, apiKey: apiKey);
    return answer.articles.toList();
  }
}
