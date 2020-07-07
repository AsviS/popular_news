import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:osam_flutter/osam_flutter.dart';

class AppPresenter extends Presenter<UIState, AppState> with NavigationPresenter {
  @override
  Navigation get navigation => uiState.appNavigation;
}
