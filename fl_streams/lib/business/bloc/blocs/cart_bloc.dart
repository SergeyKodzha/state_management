import 'dart:async';

import '../../../common/custom_bloc/custom_bloc.dart';
import '../../application/app_service.dart';
import '../events/cart_events.dart';
import '../states/cart_state.dart';

class CartBloc extends CustomBloc<CartEvent, CartState> {
  final AppService _service;
  CartBloc(this._service) : super(CartState.initial());

  @override
  void handleEvent(CartEvent event) {
    if (event is CartFetchData) {
      _fetchData(event);
    } else if (event is CartUpdateItem) {
      _updateItem(event);
    }
    if (event is CartRemoveItem) {
      _removeItem(event);
    }
  }

  Future<void> _fetchData(CartFetchData event) async {
    emit(state.copyWith(status: CartStatus.loading));
    final cart = await _service.fetchCart();
    final ids = cart.items.map((item) => item.productId).toList();
    final products = await _service.fetchCartProducts(ids);
    emit(state.copyWith(
        status: CartStatus.idle, cart: cart, products: products));
  }

  Future<void> _updateItem(CartUpdateItem event) async {
    emit(state.copyWith(status: CartStatus.busy));
    final updated = await _service.setCartItem(event.item);
    final products = state.products;
    if (!products.containsKey(event.item.productId)) {
      final product = await _service.fetchCartProducts([event.item.productId]);
      products[event.item.productId] = product.values.first;
    }
    emit(state.copyWith(
        status: CartStatus.idle, cart: updated, products: products));
  }

  Future<void> _removeItem(CartRemoveItem event) async {
    emit(state.copyWith(status: CartStatus.busy));
    final updated = await _service.removeCartItem(event.productId);
    final products = state.products;
    products.removeWhere((key, value) => key == event.productId);
    emit(state.copyWith(
        status: CartStatus.idle, cart: updated, products: products));
  }
}
