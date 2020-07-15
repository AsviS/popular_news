import 'package:clean_news_ai/features/news/domain/entities/news_scope.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:clean_news_ai/app/hive_ids.dart';

part 'app_state.g.dart';

@HiveType(typeId: HiveId.appState)
class AppState {
  @HiveField(0)
  final IProperty<NewsScope> newsScope;

  AppState({IProperty<NewsScope> newsScope}) : newsScope = newsScope ?? IProperty(NewsScope());
}
