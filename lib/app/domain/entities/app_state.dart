import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:clean_news_ai/app/hive_ids.dart';

part 'app_state.g.dart';

@HiveType(typeId: HiveId.appState)
class AppState {
  @HiveField(0)
  var _currentNewsScope = NewsScope();
  NewsScope get currentNewsScope => _currentNewsScope;
}
