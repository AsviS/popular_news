import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/osam.dart';

class NewsCardPresenter extends Presenter<Store<AppState>> {
  StateStream<bool> stream(NewsModel model) => StateStream(
      store.state.favoritesState.propertyStream((state) => state.news.containsKey(model.url)),
      store.state.favoritesState.news.containsKey(model.url));

  void addToFavorites(NewsModel model) => store.dispatchEvent(
      event: Event(reducer: (state) => state.favoritesState..addNewsModel(model)));

  void removeFromFavorites(NewsModel model) => store.dispatchEvent(
      event: Event(reducer: (state) => state.favoritesState..removeArticle(model.url)));
}
