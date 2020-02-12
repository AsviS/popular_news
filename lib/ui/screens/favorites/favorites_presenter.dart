import 'package:clean_news_ai/domain/model/news_model.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class FavoritesPresenter extends Presenter<Store<AppState>> {
  StateStream<List<NewsModel>> get stream => StateStream(
      store.state.propertyStream((state) => state.favoritesState.news.values.toList()),
      store.state.favoritesState.news.values.toList());
}
