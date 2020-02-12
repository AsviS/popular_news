import 'dart:async';

import 'package:clean_news_ai/domain/events/top_news_events.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/osam.dart';
import 'package:stream_transform/stream_transform.dart';

class BaseScreenPresenter extends Presenter<Store<AppState>> {
  void tryDownloadAgain() => store.dispatchEvent(event: FetchNewsEvent());

  Stream<ErrorEvent> get errorStream => store.eventStream.whereType<ErrorEvent>();

  void cancelDownloadingProcess() {
    store.dispatchEvent(event: Event(reducer: (state) => state.topNewsState..clearNews()));
    store.dispatchEvent(event: Event(reducer: (state) => state.settingsState..clearThemes()));
    store.dispatchEvent(event: FetchNewsEvent());
  }

  @override
  void dispose() {}
}
