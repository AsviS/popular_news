import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class SettingsPresenter extends Presenter<Store<AppState>> {
  Stream<List<String>> get themesStream =>
      store.state.settingsState.propertyStream<List<String>>((state) => state.themes);

  List<String> get initialData => store.state.settingsState.themes;

  void changeThemesForTopNewsState() {
    store.dispatchEvent(event: Event(reducer: (state) => state.topNewsState..clearNews()));
    store.dispatchEvent(
        event: Event(reducer: (state) => state.topNewsState..addNewThemes(initialData)));
  }

  void addTheme(String theme) {
    store.dispatchEvent(event: Event(reducer: (state) => state.settingsState..addTheme(theme)));
    changeThemesForTopNewsState();
  }

  void removeTheme(String theme) {
    store.dispatchEvent(event: Event(reducer: (state) => state.settingsState..removeTheme(theme)));
    changeThemesForTopNewsState();
  }

  void changeColor(int color) => store.dispatchEvent(
      event: Event(reducer: (state) => state.settingsState..changeColor(color)));

  @override
  void dispose() {
    store.dispatchEvent(event: FetchNewsEvent());
  }
}
