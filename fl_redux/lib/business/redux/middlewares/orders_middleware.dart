
import 'package:redux/redux.dart';

import '../../application/app_service.dart';
import '../actions/cart_actions.dart';
import '../actions/order_actions.dart';
import '../states/app_state.dart';



class OrdersMiddleware extends MiddlewareClass<AppState>{
  final AppService _service;

  OrdersMiddleware(this._service);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is FetchOrdersAction){
      store.dispatch(OrdersLoadingAction());
      final orders=await _service.fetchOrders();
      store.dispatch(OrdersLoadedAction(orders));
    } else if (action is DoOrderAction){
      store.dispatch(OrderingAction());
      final orders=await _service.order();
      store.dispatch(OrderCreatedAction(orders));
      store.dispatch(FetchCartDataAction());
    }
    next(action);
  }
}