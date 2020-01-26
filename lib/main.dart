import 'package:clean_news_ai/domain/repository/domain_news_repository.dart';
import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:clean_news_ai/ui/screens/base_screen_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:osam/osam.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';

import 'domain/components/app/state/app_state.dart';
import 'domain/components/favorites/state/favorites_state.dart';
import 'domain/components/navigation/state/navigation_state.dart';
import 'domain/components/settings/state/settings_state.dart';
import 'domain/components/top_news/events/top_news_events.dart';
import 'domain/components/top_news/middleware/top_news_middleware.dart';
import 'domain/components/top_news/state/top_news_state.dart';

const scrollPhysics = AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());

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
      middleWares: <Middleware<Store<AppState>>>[NewsMiddleware(NewsDomainRepository.prod())]);
//  await store.initPersist();
//  store.deleteState();
  store.dispatchEvent(event: FetchNewsEvent());
  final initialIndex = store.state.navigationState.navigationIndex;
  final appKey = GlobalKey();
  final storeKey = GlobalKey();
  runApp(MaterialApp(
      key: appKey,
      home: StoreProvider(
          key: storeKey,
          store: store,
          child: PresenterProvider<NavigationPresenter>(
              key: ValueKey('navigation'),
              presenter: NavigationPresenter(),
              child: PresenterProvider(
                key: ValueKey('baseScreen'),
                presenter: BaseScreenPresenter(),
                child: BaseScreen(
                  initialIndex: initialIndex,
                ),
              )))));
}
