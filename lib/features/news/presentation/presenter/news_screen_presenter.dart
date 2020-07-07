import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/presentation/navigation/routes.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:worker_manager/worker_manager.dart';

class NewsScreenPresenter extends Presenter<UIState, AppState> with NavigationPresenter {

  @override
  Navigation get navigation => uiState.appNavigation;

  @override
  void init() => updateNews();

  IProperty<List<NewsArticle>> get news => appState.currentNewsScope.news;

  Future<void> updateNews() => useCaseContainer.useCase<NewsUseCase>().updateNews();

  void showImage(NewsArticle article) => push(DialogRoute(article.urlToImage));

//
//  void setIsSaved(bool value, NewsArticle article) =>
//      useCaseContainer.useCase<NewsUseCase>().setIsSaved(value, article);
}
