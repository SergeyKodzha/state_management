import 'package:fl_mobx/business/entities/cart_item.dart';
import 'package:fl_mobx/business/entities/product.dart';
import 'package:fl_mobx/business/mobx/cart/cart_data.dart';
import 'package:mobx/mobx.dart';

import '../../application/app_service.dart';
import '../../entities/cart.dart';

part 'cart_store.g.dart';

class CartStore extends _CartStore with _$CartStore {
  CartStore(super.service);

}
enum CartState {idle,loading,updating}
abstract class _CartStore with Store {
  final AppService _service;

  _CartStore(this._service);

  @observable
  CartData? cartData;

  @observable
  CartState state=CartState.idle;

  @action
  Future<void> fetchCart() async {
    state=CartState.loading;
    final cart=await _service.fetchCart();
    final ids=cart.items.map((i) => i.productId).toList();
    final products=await _service.fetchCartProducts(ids);
    cartData=CartData(cart:cart,products: products);
    state=CartState.idle;
  }

  @action
  Future<void> updateCartItem(CartItem item) async {
    state=CartState.updating;
    final cart=await _service.setCartItem(item);
    final products=cartData?.products??{};
    if (!products.containsKey(item.productId)){
      final product=await _service.fetchCartProducts([item.productId]);
      products[item.productId]=product.values.first;
    }
    cartData=CartData(cart:cart,products: products);
    state=CartState.idle;
  }

  @action
  Future<void> removeCartItem(ProductID id) async {
    state=CartState.updating;
    final cart=await _service.removeCartItem(id);
    final products=cartData?.products??{};
    products.removeWhere((key, value) => key==id);
    cartData=CartData(cart:cart,products: products);
    state=CartState.idle;
  }
}