import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/event/event.dart';

class FetchNewsEvent extends Event<AppState> {}

class ErrorEvent extends Event<AppState> {}
