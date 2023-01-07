import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/order.dart';


enum OrderAction{order,ordering,load,loading,idle}
class OrderActions{
  static Action order()=>const Action(OrderAction.order);
  static Action ordering()=>const Action(OrderAction.ordering);
  static Action load()=>const Action(OrderAction.load);
  static Action loading()=>const Action(OrderAction.loading);
  static Action idle(List<Order> orders)=>Action(OrderAction.idle,payload: orders);
}