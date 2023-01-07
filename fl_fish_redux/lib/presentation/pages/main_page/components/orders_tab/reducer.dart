import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/state.dart';

import 'actions.dart';

Reducer<OrdersState> buildReducer() {
  return asReducer({
    OrderAction.loading:(state, action) {
      return state.clone()..status=OrdersStatus.loading;
    },
    OrderAction.ordering:(state, action) {
      return state.clone()..status=OrdersStatus.ordering;
    },
    OrderAction.idle:(state, action) {
      return state.clone()..orders=action.payload..status=OrdersStatus.idle;
    },
  });
}