import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:osam_flutter/osam_flutter.dart';

import 'domain/entities/app_state.dart';

// ignore: camel_case_types
abstract class hiveId {
  //domain
  static const appState = 0;
  static const newsScope = 1;
  static const newsArticle = 2;

  //ui
  static const dialogRoute = 218;
  static const rootRoute = 219;
  static const uiState = 220;
}

void registerAdapters() {
  registerOsamFlutterAdapters();
  Hive.registerAdapter(AppStateAdapter());
  Hive.registerAdapter(NewsScopeAdapter());
  Hive.registerAdapter(NewsArticleAdapter());
  Hive.registerAdapter(UIStateAdapter());
}
