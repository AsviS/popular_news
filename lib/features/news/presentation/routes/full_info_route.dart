import 'package:clean_news_ai/app/hive_ids.dart';
import 'package:clean_news_ai/features/news/domain/entities/news_article.dart';
import 'package:osam_flutter/osam_flutter.dart';

part 'full_info_route.g.dart';

@HiveType(typeId: HiveId.dialogRoute)
class FullInfoRoute extends OsamRoute {
  @HiveField(0)
  final NewsArticle argument;

  FullInfoRoute(this.argument);
}
