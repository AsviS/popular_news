import 'package:osam/domain/state/base_state.dart';
import 'package:osam/osam.dart';

part 'news_model.g.dart';

@HiveType(typeId: 5)
// ignore: must_be_immutable
class NewsModel extends BaseState<NewsModel> {
  @HiveField(0)
  final String hoursAgo;
  @HiveField(1)
  final String source;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String imageUrl;

  NewsModel({this.hoursAgo, this.source, this.title, this.url, this.imageUrl});

  @override
  List<String> get props => [hoursAgo, source, title, url, imageUrl];
}
