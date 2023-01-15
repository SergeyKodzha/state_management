import 'dart:async';

import 'package:fl_bloc/business/bloc/events/cart_events.dart';
import 'package:fl_bloc/business/bloc/events/order_events.dart';
import 'package:fl_bloc/business/bloc/states/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_service.dart';
import 'cart_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final AppService _service;
  final CartBloc _cartBloc;
  OrderBloc(this._service, this._cartBloc) : super(OrderState.initial()) {
    on<OrderFetchOrders>(_fetchOrders);
    on<OrderDoOrder>(_order);
  }

  Future<void> _order(OrderDoOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.busy));
    final orders = await _service.order();
    _cartBloc.add(CartFetchData());
    emit(state.copyWith(status: OrderStatus.idle, orders: orders));
  }

  Future<void> _fetchOrders(
      OrderFetchOrders event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final orders = await _service.fetchOrders();
    emit(state.copyWith(status: OrderStatus.idle, orders: orders));
  }
}
