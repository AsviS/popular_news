import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:osam/osam.dart';

class BaseScreenPresenter extends Presenter<Store<AppState>> {
  StreamSubscription<bool> _isFailureSub;
  StreamController<bool> _failureBroadcaster;

  Stream<bool> get failureStream => _failureBroadcaster.stream;

  bool get initialData => store.state.isFailure;

  @override
  void init() {
    _failureBroadcaster = StreamController.broadcast();
    _isFailureSub = store.state.propertyStream((state) => state.isFailure).listen((isFailure) {
      _failureBroadcaster.add(isFailure);
    });
  }

  void tryDownloadAgain() => store.dispatchEvent(event: FetchNewsEvent());

  void cancelDownloadingProcess() {
    store.dispatchEvent(
        event: Event.modify(reducer: (state, _) => state.topNewsState..clearNews()));
    store.dispatchEvent(
        event: Event.modify(reducer: (state, _) => state.settingsState..clearThemes()));
    store.dispatchEvent(event: FetchNewsEvent());
  }

  @override
  void dispose() {
    _isFailureSub?.cancel();
    _failureBroadcaster?.close();
  }
}
