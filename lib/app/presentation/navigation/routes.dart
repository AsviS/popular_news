import 'package:osam_flutter/osam_flutter.dart';
import 'package:clean_news_ai/app/hive_ids.dart';

@HiveType(typeId: hiveId.rootRoute)
class RootRoute extends OsamRoute<Null, Null> {
  RootRoute() : super(null);
  @override
  Null result;
}

@HiveType(typeId: hiveId.dialogRoute)
class DialogRoute extends OsamRoute<String, Null> {
  @override
  @HiveField(0)
  final String argument;
  @override
  Null result;

  DialogRoute(this.argument) : super(argument);
}

abstract class Tabs {
  static const top = 'top';
}
