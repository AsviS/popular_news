import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'top_news_state.g.dart';

@HiveType(typeId: 4)
// ignore: must_be_immutable
class TopNewsState extends BaseState<TopNewsState> {
  @HiveField(0)
  var news = <String, Map<String, NewsModel>>{};

  @HiveField(1)
  var scrollPosition = 0.0;

  void addNews({String theme, Map<String, NewsModel> news}) => this.news[theme] = news;

  void addNewThemes(List<String> themes) => this.news.addAll(
      Map.fromIterable(themes, key: (item) => item, value: (item) => <String, NewsModel>{}));

  void clearNews() => news.clear();

  @override
  List<Object> get props => [news];
}
