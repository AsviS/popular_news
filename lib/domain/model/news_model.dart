import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class NewsModel extends BaseState<NewsModel> {
  final String hoursAgo;
  final String source;
  final String title;
  final String content;
  final String url;
  final String imageUrl;

  NewsModel({this.hoursAgo, this.source, this.title, this.content, this.url, this.imageUrl});

  @override
  List<Object> get props => [hoursAgo, source, title, content, url, imageUrl];
}
