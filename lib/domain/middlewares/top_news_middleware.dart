import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/events/top_news_events.dart';
import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/repository/domain_news_repository.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/osam.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/runnable.dart';
import 'package:worker_manager/task.dart';

class GetTopNewsScenario {
  static Future<List<NewsModel>> getTopNews(NewsDomainRepository repository, String theme) async =>
      repository.getTopNews(theme);
}

class NewsMiddleware extends Middleware<AppState> {
  final NewsDomainRepository repository;

  NewsMiddleware(this.repository);

  final refreshingTasks = <Task2<NewsDomainRepository, String, List<Article>>>[];

  @override
  List<Condition<AppState>> get conditions => [
        (event) {
          if (event is FetchNewsEvent) {
            /// killing old tasks
            refreshingTasks
              ..forEach((task) => task.cancel())
              ..clear();

            ///creating tasks
            final tasks = store.state.settingsState.themes
                .map((theme) => Task2(
                    runnable: Runnable(
                        arg1: repository, arg2: theme, fun2: GetTopNewsScenario.getTopNews)))
                .toList();
            tasks.forEach((task) => Executor()
                .addTask(task: task)
                .listen((news) => store.dispatchEvent(
                    event: Event(
                        reducer: (state) => state.topNewsState
                          ..addNews(
                              theme: task.runnable.arg2,
                              news: Map<String, NewsModel>.fromIterable(news,
                                  key: (item) => item.url, value: (item) => item)))))
                .onError((error) => store.dispatchEvent(event: ErrorEvent())));
          }
          return nextEvent(true);
        }
      ];
}
