import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/domain/entities/news_article.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:clean_news_ai/features/news/presentation/routes/full_info_route.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:worker_manager/worker_manager.dart';

class NewsScreenPresenter extends Presenter<UIState, AppState> with NavigationPresenter {
  Cancelable<void> _updateTask;

  @override
  Navigation get navigation => uiState.appNavigation;

  Future<void> fetch() async {
    _updateTask?.cancel();
    await (_updateTask = useCaseContainer.useCase<NewsUseCase>().updateNews());
  }

  IProperty<List<NewsArticle>> get news => appState.newsScope.value.news;

  void showFullInfo(NewsArticle article) => push(FullInfoRoute(article));

}
