import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clean_news_ai/ui/drawing/drawing_presenter.dart';
import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/screens/settings_screen/settings_presenter.dart';
import 'package:clean_news_ai/ui/screens/settings_screen/settings_screen.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_screen.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_app_bar.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'base_screen_presenter.dart';
import 'favorites/favorites_presenter.dart';
import 'favorites/favorites_screen.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;

  BaseScreen({Key key, this.initialIndex}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState(initialIndex);
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin, AfterLayoutMixin {
  TabController _controller;
  final int initialIndex;

  _BaseScreenState(this.initialIndex);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PresenterProvider(
            child: NewsGradient(),
            key: ValueKey('drawingProvider'),
            presenter: DrawingPresenter(),
          ),
          TabBarView(
            controller: _controller,
            children: <Widget>[
              PresenterProvider(
                key: ValueKey('topNewsPresenter'),
                child: TopNewsScreen(PageStorageKey('news')),
                presenter: TopNewsPresenter(),
              ),
              PresenterProvider(
                key: ValueKey('favoritesPresenter'),
                presenter: FavoritesPresenter(),
                child: FavoritesScreen(PageStorageKey('favorites')),
              ),
              PresenterProvider(
                key: ValueKey('settingsPresenter'),
                child: SettingsScreen(PageStorageKey('settings')),
                presenter: SettingsPresenter(),
              ),
            ],
          ),
          NavigationAppBar(
            controller: _controller,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final presenter = PresenterProvider.of<BaseScreenPresenter>(context);
    presenter.errorStream.listen((event) => showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
              title: Text('Error'),
              content: Text('Something went wrong while news downloading process, try again?'),
              actions: <Widget>[
                CupertinoButton(
                  child: Text('cancel'),
                  onPressed: () {
                    setState(() {
                      presenter.cancelDownloadingProcess();
                      Navigator.of(context).pop();
                    });
                  },
                ),
                CupertinoButton(
                  child: Text('yes'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    presenter.tryDownloadAgain();
                  },
                ),
              ],
            )));

    if (!_controller.hasListeners) {
      Future.delayed(Duration.zero, () {
        _controller.addListener(() {
          final presenter = PresenterProvider.of<NavigationPresenter>(context);
          presenter.routeTo(_controller.index);
        });
      });
    }
  }
}
