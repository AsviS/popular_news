import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class NavigationPresenter<S extends Store<AppState>> extends Presenter<S> {
  Stream<int> get stream =>
      store.state.navigationState.propertyStream((state) => state.navigationIndex);

  int get initialData => store.state.navigationState.navigationIndex;

  void routeTo(int index) {
    store.dispatchEvent(event: Event(reducer: (state) => state.navigationState..routeTo(index)));
  }

  void refreshNavigationIndex(int index) => store.state.navigationState
    ..navigationIndex = index
    ..refreshHashcode();

  @override
  void dispose() {}
}
