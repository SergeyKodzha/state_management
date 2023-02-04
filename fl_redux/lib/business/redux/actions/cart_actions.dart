import 'package:fl_redux/business/entities/cart_item.dart';

import '../../entities/cart.dart';
import '../../entities/product.dart';

class CartAction {}

class FetchCartDataAction implements CartAction {}

class UpdateCartItemAction implements CartAction {
  final CartItem item;
  UpdateCartItemAction(this.item);
}

class CartUpdatingAction implements CartAction {}

class CartUpdatedAction implements CartAction {
  final Cart cart;

  CartUpdatedAction(this.cart);
}

class DeleteCartItemAction implements CartAction {
  final ProductID id;
  DeleteCartItemAction(this.id);
}

class CartLoadingAction implements CartAction {}

class CartLoadedAction implements CartAction {
  final Cart cart;
  final Map<ProductID, Product> products;
  CartLoadedAction({required this.cart, required this.products});
}
