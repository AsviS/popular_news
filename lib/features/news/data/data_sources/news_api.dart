import 'dart:async';
import 'dart:convert';
import 'package:clean_news_ai/features/news/data/models/answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:osam_http_client/osam_http_client.dart';

abstract class NewsApi {
  const factory NewsApi({@required HttpClient httpClient, String host}) = _NewsApi;

  Future<Answer> news({String country, String category, List<String> sources, String keyWord, int page, String apiKey});

//  Future<List<String>> sources();
}

class _NewsApi implements NewsApi {
  final HttpClient httpClient;
  final String host;

  const _NewsApi({this.httpClient, this.host});

  Future<Answer> news(
      {String country, String category, List<String> sources, String keyWord = '', int page, String
      apiKey}) async {
    final path = keyWord == ''
        ? 'country=$country&category=$category&page=$page&apiKey=$apiKey'
        : 'country=$country&q=$keyWord&page=$page&apiKey=$apiKey';
    final response = await httpClient.get(host: host, path: path);
    return Answer.fromMap(jsonDecode(response.body));
  }
}
