import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class TopNewsState extends BaseState {
  final news = <String, ArticleModel>{};

  void addNews(Map<String, ArticleModel> news) => this.news.addAll(news);

  void setFavorite(String key) => news[key].isSaved = true;

  void removeFavorite(String key) => news[key].isSaved = false;

  void cleanNews() => this.news.clear();

  @override
  Map<String, Object> get namedProps => {'news': news};
}
