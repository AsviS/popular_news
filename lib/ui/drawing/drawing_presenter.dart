import 'dart:async';

import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class DrawingPresenter extends Presenter<Store<AppState>> {
  Stream<int> get stream => store.state.settingsState.propertyStream((state) => state.color);

  int get initialData => store.state.settingsState.color;

  @override
  void dispose() {}
}
