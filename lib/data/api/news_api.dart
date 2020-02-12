import 'dart:async';
import 'package:http/http.dart';

const apiKey = '10d15b867c564e6ba33531af21905fb2';
const timeout = Duration(seconds: 3);

abstract class Api {
  Future<String> getTopArticles(String category);

  Future<String> searchArticles(String keyWord);

  factory Api() => _NewsApi();
}

class _NewsApi implements Api {
  @override
  Future<String> getTopArticles(String category) async {
    final response = await get(
            "https://newsapi.org/v2/top-headlines?country=us&category=$category&pageSize=10&apiKey"
            "=$apiKey")
        .timeout(timeout);
    final jsonData = response.body;
    return jsonData;
  }

  @override
  Future<String> searchArticles(String keyWord) async {
    final response =
        await get("https://newsapi.org/v2/everything?q=$keyWord&pageSize=3&sortBy=relevance"
                "&language=ru&apiKey=$apiKey")
            .timeout(timeout);
    final jsonData = response.body;
    return jsonData;
  }
}
