import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

const apiKey = '10d15b867c564e6ba33531af21905fb2';

// todo: add http client with logging and timeouts

abstract class Api {
  Future<String> getTopArticles({@required String category});

  Future<String> searchArticles({@required String keyWord});

  factory Api.newsAPI() => _NewsApi();
}

class _NewsApi implements Api {
  @override
  Future<String> getTopArticles({String category}) async {
    try {
      final response = await get(
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&pageSize=10&apiKey"
          "=$apiKey");
      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> searchArticles({String keyWord}) async {
    try {
      final response =
          await get("https://newsapi.org/v2/everything?q=$keyWord&pageSize=3&sortBy=relevance"
              "&language=ru&apiKey=$apiKey");
      final jsonData = response.body;
      return jsonData;
    } catch (error) {
      throw error;
    }
  }
}
