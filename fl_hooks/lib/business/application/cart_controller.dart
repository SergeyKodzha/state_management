
import 'package:fl_hooks/business/application/app_service.dart';
import 'package:fl_hooks/business/entities/product.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/hook_data_container.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';

class CartController extends HookDataContainer<Cart>{
  final AppService appService;
  //final Map<ProductID,Product> _cartProducts={};
  //Map<ProductID,Product> get cartProducts=>Map.unmodifiable(_cartProducts);
  CartController(this.appService);

  Future<void> fetchCart() async {
    state.value=(data==null?HookDataState.loading:HookDataState.updating);
    //await Future.delayed(Duration(seconds: 2));
    final cart=await appService.fetchCart();
    setData(cart);
  }
  /*
  void fetchCartProducts() async {
    final cart=data;
    if (cart!=null) {
      state.value = HookDataState.updating;
      await Future.delayed(Duration(seconds: 5));
      List<ProductID> ids=[];
      for (final item in cart.items){
        ids.add(item.productId);
      }
      final products = await appService.fetchCartProducts(ids);
      _cartProducts.clear();
      _cartProducts.addAll(products);
      state.value = HookDataState.idle;
    } else{
      //setError(const UIError('user cart not loaded'));
    }
  }
   */

  void setCartItem(CartItem item) async {
    state.value=HookDataState.updating;
    final newCart=await appService.setCartItem(item);
    setData(newCart);
  }

  void removeCartItem(ProductID id) async {
    state.value=HookDataState.updating;
    final newCart=await appService.removeCartItem(id);
    setData(newCart);
  }
}
CartController useCartController(AppService service){
  final controller=useState(CartController(service)).value;
  useListenable(controller.state);
  return controller;
}