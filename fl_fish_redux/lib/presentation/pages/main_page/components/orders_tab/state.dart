import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../business/entities/order.dart';
import '../../state.dart';

enum OrdersStatus { initial, loading, ordering, idle }

class OrdersState implements Cloneable<OrdersState> {
  ScrollController scrollController=ScrollController();
  PageStorageKey scrollKey = const PageStorageKey<String>('scroll_pos');
  OrdersStatus status = OrdersStatus.initial;
  List<Order> orders = [];

  @override
  OrdersState clone() {
    return OrdersState()
      ..scrollController = scrollController
      ..scrollKey = scrollKey
      ..status = status
      ..orders = orders;
  }
}

class OrdersConnector extends ConnOp<MainState, OrdersState> {
  @override
  OrdersState get(MainState state) {
    return state.ordersState.clone();
  }

  @override
  void set(MainState state, OrdersState subState) {
    state.ordersState = subState.clone();
  }
}
