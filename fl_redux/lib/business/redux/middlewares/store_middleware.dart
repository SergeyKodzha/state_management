import 'package:fl_redux/business/application/app_service.dart';

import 'package:redux/redux.dart';

import '../actions/store_actions.dart';
import '../states/app_state.dart';

class StoreMiddleware extends MiddlewareClass<AppState> {
  final AppService _service;

  StoreMiddleware(this._service);
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is StoreLoadAction) {
      store.dispatch(StoreLoadingAction());
      final products = await _service.fetchAllProducts();
      store.dispatch(StoreLoadedAction(products));
    }
    next(action);
  }
}
