import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'drawing_presenter.dart';

class NewsGradient extends StatelessWidget {
  const NewsGradient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<DrawingPresenter>(context);
    return StreamBuilder(
        stream: presenter.stream,
        initialData: presenter.initialData,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Color(snapshot?.data) ?? Colors.yellow])));
        });
  }
}
