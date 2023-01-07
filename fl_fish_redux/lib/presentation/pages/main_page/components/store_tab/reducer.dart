import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/state.dart';

Reducer<StoreState> buildReducer() {
  return asReducer({StoreActon.loading: _loading, StoreActon.loaded: _loaded});
}

StoreState _loading(StoreState state, Action action) {
  return state.clone()..status = StoreStatus.loading;
}

StoreState _loaded(StoreState state, Action action) {
  return state.clone()
    ..products = action.payload
    ..status = StoreStatus.loaded;
}
