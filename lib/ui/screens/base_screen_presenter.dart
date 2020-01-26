import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:osam/osam.dart';

class BaseScreenPresenter extends Presenter<Store<AppState>> {
  Stream<bool> get failureStream => store.state.propertyStream((state) => state.isFailure);

  bool get initialData => store.state.isFailure;

  void tryDownloadAgain() => store.dispatchEvent(event: FetchNewsEvent());

  void cancelDownloadingProcess() {
    store.dispatchEvent(event: Event(reducer: (state) => state.topNewsState..clearNews()));
    store.dispatchEvent(event: Event(reducer: (state) => state.settingsState..clearThemes()));
    store.dispatchEvent(event: FetchNewsEvent());
  }

  @override
  void dispose() {}
}
