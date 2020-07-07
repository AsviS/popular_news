import 'categories.dart';


class Request {
  final String country;
  final Category category;
//  final String keyWord;
  final List<String> sources;
  final int page;

  Request({this.country, this.category, this.sources, this.page});
}
