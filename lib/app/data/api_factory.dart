import 'package:clean_news_ai/app/data/hosts.dart';
import 'package:clean_news_ai/features/news/data/data_sources/news_api.dart';
import 'package:osam_http_client/osam_http_client.dart';

abstract class ApiFactory {
  const factory ApiFactory(HttpClient httpClient) = _ProdApiFactory;

  NewsApi get newsApi;
}

class _ProdApiFactory implements ApiFactory {
  final HttpClient httpClient;

  const _ProdApiFactory(this.httpClient);

  @override
  NewsApi get newsApi => NewsApi(httpClient: httpClient, host: Hosts().top);
}
