import 'package:fl_hooks/business/application/app_service.dart';
import 'package:fl_hooks/business/entities/product.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/hook_data_container.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';

class CartModel extends HookDataContainer<Cart> {
  final AppService appService;
  CartModel(this.appService);

  Future<void> fetchCart() async {
    state.value =
        (data == null ? HookDataState.loading : HookDataState.updating);
    final cart = await appService.fetchCart();
    setData(cart);
  }

  void setCartItem(CartItem item) async {
    state.value = HookDataState.updating;
    final newCart = await appService.setCartItem(item);
    setData(newCart);
  }

  void removeCartItem(ProductID id) async {
    state.value = HookDataState.updating;
    final newCart = await appService.removeCartItem(id);
    setData(newCart);
  }
}

CartModel useCartController(AppService service) {
  final controller = useState(CartModel(service)).value;
  useListenable(controller.state);
  return controller;
}
