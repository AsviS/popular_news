import 'package:osam_flutter/osam_flutter.dart';
import 'package:clean_news_ai/app/hive_ids.dart';

part 'routes.g.dart';

@HiveType(typeId: HiveId.rootRoute)
class RootRoute extends OsamRoute {}


abstract class Tabs {
  static const top = 'top';
}
