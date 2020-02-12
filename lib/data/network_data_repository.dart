import 'dart:async';

import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:clean_news_ai/data/utils/utils.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/repository/domain_news_repository.dart';

class NewsDataRepository implements NewsDomainRepository {
  final Api api;

  NewsDataRepository(this.api);

  @override
  Future<List<NewsModel>> getTopNews(String theme) async {
    final jsonData = await api.getTopArticles(theme);
    return mapFromJsonToNewsModel(jsonData);
  }

  @override
  Future<List<NewsModel>> searchNews(String keyWord) async {
    final jsonData = await api.searchArticles(keyWord);
    return mapFromJsonToNewsModel(jsonData);
  }
}
