
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/injector.dart';
import 'package:fl_fish_redux/presentation/pages/details_page/page.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/state.dart';
import 'package:flutter/material.dart' hide Action;

Effect<StoreState> buildEffect() {
  return combineEffects({
    Lifecycle.initState:_init,
    StoreActon.load:_load,
    StoreActon.productTap:_goToDetails,
  });
}

void _init(Action action,Context<StoreState> ctx) {
  if (ctx.state.status==StoreStatus.initial) {
    ctx.dispatch(StoreActions.load());
  }
}

void _load(Action action,Context<StoreState> ctx) async {
  final service=Injector.instance.appService;
  ctx.dispatch(StoreActions.loading());
  final products= await service.fetchAllProducts();
  ctx.state.products=products;
  ctx.dispatch(StoreActions.loaded(products));
}

_goToDetails(Action action,Context<StoreState> ctx) async {
  ctx.dispatch(MainPageActions.showDetails(action.payload));
  //Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) => DetailsPage().buildPage({}),));
}