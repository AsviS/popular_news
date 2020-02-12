import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:clean_news_ai/ui/screens/base_screen_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:osam/osam.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';

import 'data/network_data_repository.dart';
import 'domain/events/top_news_events.dart';
import 'domain/middlewares/top_news_middleware.dart';
import 'domain/states/app_state.dart';
import 'domain/states/favorites_state.dart';
import 'domain/states/navigation_state.dart';
import 'domain/states/settings_state.dart';
import 'domain/states/top_news_state.dart';

Future<void> registerAdapters() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(AppStateAdapter());
  Hive.registerAdapter(TopNewsStateAdapter());
  Hive.registerAdapter(FavoritesStateAdapter());
  Hive.registerAdapter(SettingsStateAdapter());
  Hive.registerAdapter(NavigationStateAdapter());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Executor().warmUp();
  await registerAdapters();
  final store = Store(AppState(),
      middleWares: <Middleware<AppState>>[NewsMiddleware(NewsDataRepository(Api()))]);
//  await store.initPersist();
//  store.deleteState();
  store.dispatchEvent(event: FetchNewsEvent());
  final initialIndex = store.state.navigationState.navigationIndex;
  runApp(MaterialApp(
      home: StoreProvider(
          store: store,
          child: PresenterProvider(
              key: ValueKey('navigation'),
              presenter: NavigationPresenter(),
              child: PresenterProvider(
                  key: ValueKey('base_screen'),
                  presenter: BaseScreenPresenter(),
                  child: BaseScreen(
                    initialIndex: initialIndex,
                  ))))));
}
