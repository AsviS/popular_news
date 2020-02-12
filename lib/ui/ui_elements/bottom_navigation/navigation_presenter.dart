import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class NavigationPresenter extends Presenter<Store<AppState>> {
  StateStream<int> get stream => StateStream(
      store.state.navigationState.propertyStream((state) => state.navigationIndex),
      store.state.navigationState.navigationIndex);

  void routeTo(int index) => store.dispatchEvent(
      event: Event(reducer: (state) => state.navigationState..navigationIndex = index));

  void refreshNavigationIndex(int index) => store.state.navigationState
    ..navigationIndex = index
    ..refreshHashcode();
}
