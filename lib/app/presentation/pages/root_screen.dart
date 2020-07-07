import 'package:clean_news_ai/app/domain/entities/app_state.dart';
import 'package:clean_news_ai/app/presentation/navigation/routes.dart';
import 'package:clean_news_ai/app/presentation/presenter/app_navigation_presenter.dart';
import 'package:clean_news_ai/app/presentation/state/ui_state.dart';
import 'package:clean_news_ai/features/news/presentation/pages/news_screen.dart';
import 'package:clean_news_ai/features/news/presentation/presenter/news_screen_presenter.dart';
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
        DialogRoute: (ctx) => PresenterProvider(
              presenter: DialogPresenter(),
              child: Builder(
                builder: (ctx) {
                  return Image.network(
                    ctx.presenter<DialogPresenter>().tag,
                    fit: BoxFit.cover,
                  );
                },
              ),
            )
      },
    );
  }
}

class DialogPresenter extends Presenter<UIState, AppState> with NavigationPresenter {
  @override
  Navigation get navigation => uiState.appNavigation;

  String get tag => findRoute<DialogRoute>().argument;
}
