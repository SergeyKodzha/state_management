import '../../domain/entities/Cart.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';

abstract class RemoteRepository {
  Future<List<Product>> fetchAllProducts();

  Future<Map<ProductID, Product>> fetchCartProducts(List<ProductID> ids);

  Future<bool> takeGuestCart(String uid);

  Future<Cart> fetchCart(String uid);

  Future<void> setCart(String uid, Cart cart);

  Future<Order?> order(String uid);

  Future<Order?> fetchOrder(String uid);
}
