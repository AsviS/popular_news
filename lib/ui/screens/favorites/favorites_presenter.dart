import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class FavoritesPresenter extends Presenter<Store<AppState>> {
  List<NewsModel> get initialData => store.state.favoritesState.news.values.toList();

  Stream<List<NewsModel>> get stream =>
      store.state.propertyStream((state) => state.favoritesState.news.values);

  @override
  void dispose() {}
}
