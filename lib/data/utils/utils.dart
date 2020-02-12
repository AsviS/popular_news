import 'dart:convert';

import 'package:clean_news_ai/data/dto/answer.dart';
import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:intl/intl.dart';

const datePattern = "yyyy-MM-dd'T'HH:mm:ss";

List<NewsModel> mapFromJsonToNewsModel(String jsonData) {
  final answer = Answer.fromMap(json.decode(jsonData));
  return answer.articles
      .map((article) => NewsModel(
          hoursAgo: _getTimeAgo(article),
          source: article.source.name,
          title: article.title,
          url: article.url,
          imageUrl: article.urlToImage))
      .toList();
}

String _getTimeAgo(Article article) {
  final dateFormat = DateFormat(datePattern);
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
