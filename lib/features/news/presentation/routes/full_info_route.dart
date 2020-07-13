import 'package:clean_news_ai/app/hive_ids.dart';
import 'package:clean_news_ai/features/news/domain/use_cases/news_usecase.dart';
import 'package:osam_flutter/osam_flutter.dart';

part 'full_info_route.g.dart';

@HiveType(typeId: HiveId.dialogRoute)
class FullInfoRoute extends OsamRoute<NewsArticle, Null> {
  @override
  @HiveField(0)
  final NewsArticle argument;
  @override
  Null result;

  FullInfoRoute(this.argument) : super(argument: argument);
}
