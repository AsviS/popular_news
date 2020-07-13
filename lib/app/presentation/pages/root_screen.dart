import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/presentation/navigation/routes.dart';
import 'package:clean_news_ai/app/presentation/presenter/app_navigation_presenter.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:clean_news_ai/features/news/presentation/pages/news_screen.dart';
import 'package:clean_news_ai/features/news/presentation/presenter/news_screen_presenter.dart';
import 'package:clean_news_ai/features/news/presentation/routes/full_info_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osam_flutter/osam_flutter.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OsamNavigator<AppPresenter>(
      routes: {
        RootRoute: (ctx) => PresenterProvider(
              presenter: NewsScreenPresenter(),
              child: const NewsScreen(),
            ),
        FullInfoRoute: (ctx) => PresenterProvider(
              presenter: DialogPresenter(),
              child: Builder(
                builder: (ctx) {
                  return SafeArea(
                    child: Material(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Hero(
                              tag: ctx.presenter<DialogPresenter>().currentNewsArticle.url,
                              child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Image.network(
                                  ctx.presenter<DialogPresenter>().currentNewsArticle.urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Text(
                              ctx.presenter<DialogPresenter>().currentNewsArticle.description,
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
      },
    );
  }
}

class DialogPresenter extends Presenter<UIState, AppState> with NavigationPresenter {
  NewsArticle currentNewsArticle;

  @override
  void init() {
    currentNewsArticle = findRoute<FullInfoRoute>().argument;
    super.init();
  }

  @override
  Navigation get navigation => uiState.appNavigation;
}
