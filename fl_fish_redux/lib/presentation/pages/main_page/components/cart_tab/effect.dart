import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart_item.dart';
import 'package:fl_fish_redux/business/entities/product.dart';
import 'package:fl_fish_redux/injector.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';

import '../../../details_page/actions.dart';

Effect<CartState> buildEffect() {
  return combineEffects({
    Lifecycle.initState:_init,
    CartAction.load:_load,
    CartAction.setItem:_setItem,
    CartAction.removeItem:_removeItem,
    CartAction.updating:_updating,
  });
}

void _init(Action action, Context<CartState> ctx) {
  if (ctx.state.status==CartStatus.initial) {
    ctx.dispatch(CartActions.load());
  }
}

Future<void> _load(Action action, Context<CartState> ctx) async {
  final service=Injector.instance.appService;
  ctx.dispatch(CartActions.loading());
  final cart=await service.fetchCart();
  final ids=cart.items.map((i) => i.productId).toList();
  final products=await service.fetchCartProducts(ids);
  ctx.dispatch(CartActions.loaded(cart, products));
}

Future<void> _setItem(Action action, Context<CartState> ctx) async {
  final item=action.payload as CartItem;
  final service=Injector.instance.appService;
  ctx.dispatch(CartActions.updating());
  final updatedCart=await service.setCartItem(item);
  final updatedProducts=ctx.state.products;
  if (!updatedProducts.keys.contains(item.productId)){
    final tmp=await service.fetchCartProducts([item.productId]);
    final newProduct=tmp.values.first;
    updatedProducts[item.productId]=newProduct;
  }
  ctx.dispatch(CartActions.loaded(updatedCart, updatedProducts));
  ctx.broadcast(DetailsActions.updated(item));
}

Future<void> _removeItem(Action action, Context<CartState> ctx) async {
  final id=action.payload as ProductID;
  final service=Injector.instance.appService;
  ctx.dispatch(CartActions.updating());
  final updatedCart=await service.removeCartItem(id);
  final updatedProducts=ctx.state.products;
  updatedProducts.removeWhere((key, value) => key==id);
  ctx.dispatch(CartActions.loaded(updatedCart, updatedProducts));
  ctx.broadcast(DetailsActions.setEnabled(true));
}

void _updating(Action action, Context<CartState> ctx) {
  ctx.broadcast(DetailsActions.setEnabled(false));
  ctx.dispatch(CartActions.updatingInternal());
}