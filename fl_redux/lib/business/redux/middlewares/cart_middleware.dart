import 'package:fl_redux/business/application/app_service.dart';
import 'package:fl_redux/business/entities/product.dart';
import 'package:redux/redux.dart';
import '../actions/cart_actions.dart';
import '../states/app_state.dart';

class CartMiddleware extends MiddlewareClass<AppState> {
  final AppService _service;

  CartMiddleware(this._service);
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchCartDataAction) {
      store.dispatch(CartLoadingAction());
      final cart = await _service.fetchCart();
      final List<ProductID> ids = [];
      for (final item in cart.items) {
        ids.add(item.productId);
      }
      final products = await _service.fetchCartProducts(ids);
      store.dispatch(CartLoadedAction(cart: cart, products: products));
    } else if (action is UpdateCartItemAction) {
      store.dispatch(CartUpdatingAction());
      final newCart = await _service.setCartItem(action.item);
      store.dispatch(CartUpdatedAction(newCart));
    } else if (action is DeleteCartItemAction) {
      store.dispatch(CartUpdatingAction());
      final newCart = await _service.removeCartItem(action.id);
      store.dispatch(CartUpdatedAction(newCart));
    }
    next(action);
  }
}
