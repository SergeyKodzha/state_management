import '../../entities/order.dart';

enum OrderStatus{loading,busy,idle}
class OrderState{
  final OrderStatus status;
  final List<Order> orders;

  OrderState({required this.status, required this.orders});
  OrderState.initial():status=OrderStatus.idle,orders=[];
  OrderState copyWith({OrderStatus? status,List<Order>? orders})=>OrderState(status: status??this.status, orders: orders??this.orders);
}