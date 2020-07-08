
import 'package:clean_news_ai/app/data/api_factory.dart';
import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/hive_ids.dart';
import 'package:clean_news_ai/app/presentation/pages/root_screen.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/data/repositories/news_repository_impl.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:flutter/material.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:osam_http_client/osam_http_client.dart';
import 'app/presentation/presenter/app_navigation_presenter.dart';
import 'package:worker_manager/worker_manager.dart';

final navKey = GlobalKey<NavigatorState>();
final currentContext = navKey.currentState.overlay.context;

const version = 6;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _apiFactory = ApiFactory(HttpClient(log: false, timeout: Duration(seconds: 5)));
  await Executor().warmUp();


  final persist = Persist<AppState, UIState>(appName: 'news_app');
  registerAdapters();
  final persistedVersion = await persist.version;
  if ((persistedVersion ?? -1) < version) {
    await persist.delete();
  }
  await persist.init();
  final appState = persist.appState ?? AppState();
  final uiState = persist.uiState ?? UIState();

  final usecaseContainer = UseCaseContainer(
      [NewsUseCase(NewsRepositoryImpl(_apiFactory.newsApi), appState.currentNewsScope)]);
  runApp(OsamProvider(
    useCaseContainer: usecaseContainer,
    appState: appState,
    uiState: uiState,
    version: version,
    child: PersistLifecycleWrapper(
      persist: persist,
      child: PresenterProvider(
        presenter: AppPresenter(),
        child: MaterialApp(
          navigatorKey: navKey,
          home: const RootScreen(),
        ),
      ),
    ),
  ));
}
