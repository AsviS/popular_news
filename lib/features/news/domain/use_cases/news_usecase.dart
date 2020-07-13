import 'package:clean_news_ai/features/news/domain/entities/categories.dart';
import 'package:clean_news_ai/features/news/domain/entities/request.dart';
import 'package:clean_news_ai/features/news/domain/repositories/news_repository.dart';
import 'package:osam_flutter/osam_flutter.dart';
import 'package:clean_news_ai/app/hive_ids.dart';
import 'package:worker_manager/worker_manager.dart';

part '../entities/news_scope.dart';

part '../entities/news_article.dart';

part 'news_usecase.g.dart';

class NewsUseCase extends UseCase {
  final NewsScope _newsScope;
  final NewsRepository _newsRepository;

  NewsUseCase(this._newsRepository, this._newsScope);

  Cancelable<void> updateNews() {
    return _newsRepository
        .news(Request(
            country: 'us',
            category: Category.technology.toString().replaceAll('Category.', ''),
            page: 0))
        .then((news) => _newsScope._fetchNewNews(news));
  }

  void setIsSaved(bool value, NewsArticle article) => setValue(article.isSaved, value);
}
