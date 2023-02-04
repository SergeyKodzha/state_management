

import '../../entities/order.dart';

class OrderAction{}
class DoOrderAction{}
class OrderingAction{}
class OrderCreatedAction{
  final List<Order> orders;

  OrderCreatedAction(this.orders);
}
class FetchOrdersAction{}
class OrdersLoadingAction{}
class OrdersLoadedAction{
  final List<Order> orders;

  OrdersLoadedAction(this.orders);
}