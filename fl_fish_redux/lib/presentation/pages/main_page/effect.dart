


import 'package:collection/collection.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart_item.dart';
import 'package:fl_fish_redux/business/entities/product.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/page.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/actions.dart';

import 'package:fl_fish_redux/presentation/pages/main_page/state.dart';
import 'package:flutter/material.dart' hide Action;

import '../details_page/page.dart';
import 'actions.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    Lifecycle.initState:_init,
    Lifecycle.dispose:_dispose,
    MainPageAction.login:_login,
    MainPageAction.showDetails:_showDetails,
    MainPageAction.order:_order,
    MainPageAction.showTab:(action,ctx) {
      ctx.state.tabController.animateTo(action.payload);
      ctx.dispatch(MainPageActions.action());
    },
  });
}

void _init(Action action, Context<MainState> ctx) {
  print('app init');
  ctx.state.tabController=TabController(length: 3, vsync: ctx.stfState as TickerProvider);
}

void _dispose(Action action, Context<MainState> ctx) {
  ctx.state.tabController.dispose();
}

void _login(Action action, Context<MainState> context) async {
  Navigator.of(context.context).push(MaterialPageRoute(builder: (context) => AuthPage().buildPage(null),)).then((user) {
    context.dispatch(MainPageActions.setUser(user));
    if (user!=null) {
      context.dispatch(StoreActions.load());
      context.dispatch(CartActions.load());
      context.dispatch(OrderActions.load());
    }
  });
}

void _order(Action action, Context<MainState> ctx) {
  if (ctx.state.user==null){
    ctx.dispatch(MainPageActions.login());
  } else {
    ctx.dispatch(OrderActions.order());
    ctx.dispatch(MainPageActions.showTab(2));

  }
}

void _showDetails(Action action, Context<MainState> ctx) {
  if (ctx.state.cartState.status!=CartStatus.loaded){
    ScaffoldMessenger.of(ctx.context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.red,
          content: SizedBox(height: 20, child: Center(child: Text('Cart not loaded')))),
    );
  } else {
    final product=action.payload as Product;
    final item=ctx.state.cartState.cart.items.firstWhereOrNull((i)=>i.productId==product.id)??CartItem(product.id,0);
    Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) => DetailsPage().buildPage({'product':product,'item':item})));
  }
}