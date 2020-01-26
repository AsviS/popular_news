import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:clean_news_ai/data/network_data_repository.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';

abstract class NewsDomainRepository {
  factory NewsDomainRepository.prod() => NewsDataRepository(Api.newsAPI());

  Future<List<NewsModel>> getTopNews(String theme);
  Future<List<NewsModel>> searchNews(String keyWord);
}
