import 'package:clean_news_ai/domain/model/news_model.dart';

abstract class NewsDomainRepository {
  Future<List<NewsModel>> getTopNews(String theme);
  Future<List<NewsModel>> searchNews(String keyWord);
}
