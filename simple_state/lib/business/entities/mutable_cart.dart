import 'cart.dart';
import 'cart_item.dart';
import 'product.dart';

extension MutableCart on Cart {
  Cart addItem(CartItem item) {
    final List<CartItem> copy = List.from(items);
    copy.add(item);
    return Cart(copy);
  }

  Cart setItem(CartItem to) {
    final List<CartItem> itemsCopy = List.from(items);
    final index =
        itemsCopy.indexWhere((item) => item.productId == to.productId);
    if (index >= 0) {
      print('item updated ${to.quantity}');
      itemsCopy[index] = to;
    } else {
      print('new item added');
      itemsCopy.add(to);
    }
    return Cart(itemsCopy);
  }

  Cart removeItemById(ProductID productId) {
    final List<CartItem> copy = List.from(items);
    copy.removeWhere((item) => item.productId == productId);
    return Cart(copy);
  }
}
