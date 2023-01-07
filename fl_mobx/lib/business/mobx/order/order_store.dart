import 'package:fl_mobx/business/application/app_service.dart';
import 'package:mobx/mobx.dart';

import '../../entities/order.dart';
import '../cart/cart_store.dart';

part 'order_store.g.dart';

class OrderStore extends _OrderStore with _$OrderStore {
  OrderStore(super.service, super.cartStore);
}
enum OrderState{idle,loading,ordering}
abstract class _OrderStore with Store {
    final AppService _service;
    final CartStore _cartStore;

  _OrderStore(this._service, this._cartStore);

  @observable
  OrderState state=OrderState.idle;


  @observable
  List<Order> orders=[];

  @action
  fetchOrders() async {
    state=OrderState.loading;
    orders=await _service.fetchOrders();
    state=OrderState.idle;
  }

    @action
    order() async {
      state=OrderState.ordering;
      orders=await _service.order();
      state=OrderState.idle;
      _cartStore.fetchCart();
    }
}