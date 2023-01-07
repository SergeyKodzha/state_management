// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on _OrderStore, Store {
  late final _$stateAtom = Atom(name: '_OrderStore.state', context: context);

  @override
  OrderState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(OrderState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$ordersAtom = Atom(name: '_OrderStore.orders', context: context);

  @override
  List<Order> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(List<Order> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$fetchOrdersAsyncAction =
      AsyncAction('_OrderStore.fetchOrders', context: context);

  @override
  Future fetchOrders() {
    return _$fetchOrdersAsyncAction.run(() => super.fetchOrders());
  }

  late final _$orderAsyncAction =
      AsyncAction('_OrderStore.order', context: context);

  @override
  Future order() {
    return _$orderAsyncAction.run(() => super.order());
  }

  @override
  String toString() {
    return '''
state: ${state},
orders: ${orders}
    ''';
  }
}
