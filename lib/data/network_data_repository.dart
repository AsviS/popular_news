import 'dart:async';
import 'dart:convert';

import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:clean_news_ai/data/dto/answer.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/repository/domain_news_repository.dart';
import 'package:intl/intl.dart';

import 'dto/article.dart';

const datePattern = "yyyy-MM-dd'T'HH:mm:ss";

class NewsDataRepository implements NewsDomainRepository {
  final Api api;
  final dateFormat = DateFormat(datePattern);

  NewsDataRepository(this.api);

  List<NewsModel> _mapFromJsonToNewsModel(String jsonData) {
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles
        .map((article) => NewsModel(
            hoursAgo: _getTimeAgo(article),
            source: article.source?.name ?? '',
            content: article.content ?? '',
            title: article.title ?? '',
            url: article.url ?? '',
            imageUrl: article.urlToImage ?? ''))
        .toList();
  }

  @override
  Future<List<NewsModel>> getTopNews(String theme) async {
    final jsonData = await api.getTopArticles(category: theme);
    return _mapFromJsonToNewsModel(jsonData);
  }

  @override
  Future<List<NewsModel>> searchNews(String keyWord) async {
    final jsonData = await api.searchArticles(keyWord: keyWord);
    return _mapFromJsonToNewsModel(jsonData);
  }

  String _getTimeAgo(Article article) {
    if (article.publishedAt == null) return '';
    DateTime unformedDate = dateFormat.parse(article.publishedAt);
    final hoursNumber = DateTime.now().difference(unformedDate).inHours;
    final lastNumber = hoursNumber % 10;
    String time;
    if (lastNumber < 2) {
      time = hoursNumber.toString() + ' hours ago';
    } else if (lastNumber < 5) {
      time = hoursNumber.toString() + ' hours ago';
    } else {
      time = hoursNumber.toString() + ' hours ago';
    }
    return time;
  }
}
