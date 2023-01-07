import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/injector.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/state.dart';

import 'actions.dart';

Effect<OrdersState> buildEffect() {
  return combineEffects({
    Lifecycle.initState:_init,
    OrderAction.load:_load,
    OrderAction.order:_order,
  });
}

void _init(Action action, Context<OrdersState> ctx) {
  if (ctx.state.status==OrdersStatus.initial) {
    ctx.dispatch(OrderActions.load());
  }
}

void _load(Action action, Context<OrdersState> ctx) async {
  final service=Injector.instance.appService;
  ctx.dispatch(OrderActions.loading());
  final orders=await service.fetchOrders();
  ctx.dispatch(OrderActions.idle(orders));

}

void _order(Action action, Context<OrdersState> ctx) async {
  final service=Injector.instance.appService;
  ctx.dispatch(OrderActions.ordering());
  final orders=await service.order();
  ctx.dispatch(OrderActions.idle(orders));
  ctx.dispatch(CartActions.load());
}