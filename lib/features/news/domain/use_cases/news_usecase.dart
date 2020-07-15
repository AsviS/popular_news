import 'package:clean_news_ai/features/news/domain/entities/categories.dart';
import 'package:clean_news_ai/features/news/domain/entities/news_scope.dart';
import 'package:clean_news_ai/features/news/domain/entities/request.dart';
import 'package:clean_news_ai/features/news/domain/repositories/news_repository.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:worker_manager/worker_manager.dart';

class NewsUseCase extends UseCase {
  final IProperty<NewsScope> newsScope;
  final NewsRepository _newsRepository;

  NewsUseCase(this._newsRepository, this.newsScope);

  Cancelable<void> updateNews() {
    return _newsRepository
        .news(Request(
            country: 'us',
            category: Category.technology.toString().replaceAll('Category.', ''),
            page: 0))
        .then((news) => newsScope.value.updateNews(news));
  }
}
