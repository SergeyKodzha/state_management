import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/state.dart';
import 'package:flutter/material.dart';

import '../../../business/entities/user.dart';
import 'components/cart_tab/state.dart';
import 'components/store_tab/state.dart';

class MainState implements Cloneable<MainState> {
  User? user;
  late TabController tabController;
  int get currentTab => tabController.index;
  StoreState storeState = StoreState();
  CartState cartState = CartState();
  OrdersState ordersState = OrdersState();
  @override
  MainState clone() {
    return MainState()
      ..tabController = tabController
      ..storeState = storeState
      ..cartState = cartState
      ..ordersState = ordersState
      ..user = user;
  }
}
