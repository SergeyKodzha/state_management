import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/details_page/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';
import 'package:flutter/material.dart' hide Action;

import '../main_page/components/cart_tab/actions.dart';
import 'actions.dart';

Effect<DetailsState> buildEffect() {
  return combineEffects(<Object, Effect<DetailsState>>{
    DetailsAction.updateItem:_update,
    DetailsAction.setEnabled:(action, ctx) {
      ctx.dispatch(DetailsActions.setEnabledInternal(action.payload));
    },
    DetailsAction.updated:(action, ctx) {
      ctx.dispatch(DetailsActions.updatedInternal(action.payload));
    },
    DetailsAction.goToCart:_goToCart,
  });
}

void _update(Action action, Context<DetailsState> ctx) {
  ctx.broadcast(CartActions.setItem(action.payload));
}
void _goToCart(Action action, Context<DetailsState> ctx){
  Navigator.of(ctx.context).pop(true);
  ctx.broadcast(MainPageActions.showTab(1));
}