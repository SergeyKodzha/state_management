import '../../entities/order.dart';

enum OrdersState{idle,loading,ordering}
class OrdersTabData{
  final OrdersState state;
  final List<Order> orders;

  OrdersTabData({required this.state, required this.orders});
  OrdersTabData.initial():state=OrdersState.idle,orders=[];
  OrdersTabData copyWith({OrdersState? state,List<Order>? orders})=>OrdersTabData(state:state??this.state, orders:orders??this.orders);
}