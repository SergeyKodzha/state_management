import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';

Reducer<CartState> buildReducer() {
  return asReducer({
    CartAction.loading: _loading,
    CartAction.loaded: _loaded,
    CartAction.updatingInternal: _updating
  });
}

CartState _loading(CartState state, Action action) {
  return state.clone()..status = CartStatus.loading;
}

CartState _updating(CartState state, Action action) {
  return state.clone()..status = CartStatus.updating;
}

CartState _loaded(CartState state, Action action) {
  return state.clone()
    ..status = CartStatus.loaded
    ..cart = action.payload['cart']
    ..products = action.payload['products'];
}
