import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:osam/osam.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';

import 'data/database/database_repository.dart';
import 'data/dto/article.g.dart';
import 'data/dto/source.g.dart';
import 'domain/middleware/favorite_middleware.dart';
import 'domain/middleware/news_middleware.dart';

const isolatePoolSize = 2;

void main() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(SourceAdapter(), 221);
  Hive.registerAdapter(ArticleAdapter(), 222);
  await DatabaseRepository.hive().init();
  await Executor(isolatePoolSize: isolatePoolSize).warmUp();
  runApp(MaterialApp(
      home: StoreProvider(
    store: Store(
        states: [TopNewsState(), FavoritesState()],
        middleWares: [NewsMiddleware(), FavoriteMiddleware()])
      ..dispatchEvent<FavoritesState>(event: Event.sideEffect(type: EventType.fetchFavorites))
      ..dispatchEvent<TopNewsState>(
          event: Event.sideEffect(type: EventType.fetchNews, bundle: 'sport')),
    child: BaseScreen(),
  )));
}
