import 'dart:core';

import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';
import 'package:share/share.dart';

import 'news_card_presenter.dart';

class NewsCard extends StatefulWidget {
  final GlobalKey<SliverAnimatedListState> listKey;
  final int index;
  final NewsModel model;

  const NewsCard({
    Key key,
    this.listKey,
    this.index,
    this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with TickerProviderStateMixin {
  NewsModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<NewsCardPresenter>(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 4.0),
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(
                      child: Text(model.source, style: TextStyle(color: CupertinoColors.white))),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.reply, color: Colors.white),
                        onPressed: () async {
                          Share.share(model.url);
                        },
                      ),
                      OsamBuilder(
                        stream: presenter.stream(model),
                        builder: (ctx, AsyncSnapshot<bool> snapshot) {
                          return IconButton(
                            icon: Icon(
                                snapshot.data ? CupertinoIcons.book_solid : CupertinoIcons.book,
                                color: Colors.white),
                            onPressed: () async {
                              snapshot.data
                                  ? presenter.removeFromFavorites(model)
                                  : presenter.addToFavorites(model);
                              if (snapshot.data) {
                                widget.listKey.currentState.removeItem(
                                    widget.index,
                                    (ctx, animation) => AbsorbPointer(
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: SizeTransition(
                                              sizeFactor: animation,
                                              child: PresenterProvider(
                                                key: ValueKey(this.widget.key),
                                                presenter: NewsCardPresenter(),
                                                child: NewsCard(),
                                              ),
                                            ),
                                          ),
                                        ));
                              }
                            },
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child:
                  Text(model.title, style: TextStyle(color: CupertinoColors.white, fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(model.hoursAgo, style: TextStyle(color: CupertinoColors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
