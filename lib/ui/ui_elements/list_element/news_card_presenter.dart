import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:osam/osam.dart';

class NewsCardPresenter extends Presenter<Store<AppState>> {
  final NewsModel model;

  NewsCardPresenter(this.model);

  bool get initialData => store.state.favoritesState.news.containsKey(model.url);

  Stream<bool> get stream =>
      store.state.favoritesState.propertyStream((state) => state.news.containsKey(model.url));

  void addToFavorites() => store.dispatchEvent(
      event: Event(reducer: (state) => state.favoritesState..addNewsModel(model)));

  void removeFromFavorites() {
    store.dispatchEvent(
        event: Event(reducer: (state) => state.favoritesState..removeArticle(model.url)));
  }

  @override
  void dispose() {}
}
