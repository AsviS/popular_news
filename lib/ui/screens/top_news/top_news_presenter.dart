import 'dart:async';

import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class TopNewsPresenter extends Presenter<Store<AppState>> {
  Stream<Map<String, Map<String, NewsModel>>> get stream => store.state.topNewsState
      .propertyStream<Map<String, Map<String, NewsModel>>>((state) => state.news);

  Map<String, Map<String, NewsModel>> get initialData => store.state.topNewsState.news;

  @override
  void dispose() {}
}
