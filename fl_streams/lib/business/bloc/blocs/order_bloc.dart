import 'dart:async';

import '../../../common/custom_bloc/custom_bloc.dart';
import '../../application/app_service.dart';
import '../events/cart_events.dart';
import '../events/order_events.dart';
import '../states/order_state.dart';
import 'cart_bloc.dart';

class OrderBloc extends CustomBloc<OrderEvent, OrderState> {
  final AppService _service;
  final CartBloc _cartBloc;
  OrderBloc(this._service, this._cartBloc) : super(OrderState.initial());

  @override
  void handleEvent(OrderEvent event) {
    if (event is OrderDoOrder) {
      _order(event);
    } else if (event is OrderFetchOrders) {
      _fetchOrders(event);
    }
  }

  Future<void> _order(OrderDoOrder event) async {
    emit(state.copyWith(status: OrderStatus.busy));
    final orders = await _service.order();
    _cartBloc.add(CartFetchData());
    emit(state.copyWith(status: OrderStatus.idle, orders: orders));
  }

  Future<void> _fetchOrders(OrderFetchOrders event) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final orders = await _service.fetchOrders();
    emit(state.copyWith(status: OrderStatus.idle, orders: orders));
  }
}
