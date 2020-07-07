import 'package:clean_news_ai/features/news/data/data_sources/news_api.dart';
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
  Future<List<NewsArticle>> news(Request request) async {
    final answer = await api.news(
        category: request.category.toString().replaceAll('Category.', ''),
        country: request.country,
        page: request.page,
        apiKey: apiKeys.first);
    return answer.articles
        .map((e) => NewsArticle(
        source: e.source?.name ?? '',
        author: e.author ?? '',
        title: e.title ?? '',
        description: e.description ?? '',
        url: e.url ?? '',
        urlToImage: e.urlToImage ?? '',
        publishedAt: e.publishedAt ?? ''))
        .toList();
//    return Executor().execute(arg1: api, arg2: request, fun2: _news);
  }

  static Future<List<NewsArticle>> _news(NewsApi api, Request request) async {

  }
}
