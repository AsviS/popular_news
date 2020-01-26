import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/repository/domain_news_repository.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/runnable.dart';
import 'package:worker_manager/task.dart';

class NewsMiddleware extends Middleware<Store<AppState>> {
  final NewsDomainRepository repository;

  NewsMiddleware(this.repository);

  final refreshingTasks = <Task2<NewsDomainRepository, String, List<Article>>>[];

  void _fetchEvents(String theme, List<NewsModel> models) {
    final mapOfModels =
        Map<String, NewsModel>.fromIterable(models, key: (item) => item.url, value: (item) => item);
    store.dispatchEvent(
        event: Event(
            reducer: (state) => state.topNewsState..addNews(theme: theme, news: mapOfModels)));
  }

  bool getTopNews(Event event) {
    if (event is FetchNewsEvent) {
      store.dispatchEvent(event: Event(reducer: (state) => state..setIsFailure(false)));

      /// killing old tasks
      if (refreshingTasks.isNotEmpty) {
        refreshingTasks.forEach((task) {
          task.cancel();
        });
        refreshingTasks.clear();
      }

      ///creating tasks
      final tasks = store.state.settingsState.themes
          .map((theme) => Task2(
              runnable:
                  Runnable(arg1: repository, arg2: theme, fun2: GetTopNewsScenario.getTopNews)))
          .toList();
      tasks.forEach((task) {
        Executor().addTask(task: task).listen((news) {
          print(news);
          _fetchEvents(task.runnable.arg2, news);
        }).onError((error) {
          print(error);
          if (!store.state.isFailure) {
            store.dispatchEvent(event: Event(reducer: (state) => state..setIsFailure(true)));
          }
        });
      });
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [getTopNews];
}

class GetTopNewsScenario {
  static Future<List<NewsModel>> getTopNews(NewsDomainRepository repository, String theme) async =>
      repository.getTopNews(theme);
}
