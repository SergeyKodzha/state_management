import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart.dart';

import '../../../../../business/entities/product.dart';
import '../../state.dart';

enum CartStatus { initial, loading, updating,loaded }

class CartState extends Cloneable<CartState> {
  CartStatus status = CartStatus.initial;
  Cart cart=Cart(const []);
  Map<ProductID, Product> products={};

  @override
  CartState clone() {
    return CartState()
      ..status = status
      ..cart = cart
      ..products = products;
  }
}

class CartConnector extends ConnOp<MainState, CartState> {
  @override
  CartState get(MainState state) {
    return state.cartState.clone();
  }
  @override
  void set(MainState state, CartState subState) {
    state.cartState=subState.clone();
  }
}