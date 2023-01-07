
import '../entities/cart.dart';
import '../entities/product.dart';

abstract class LocalRepository{
  Future<List<Product>> fetchAllProducts();
  Future<Map<ProductID,Product>> fetchCartProducts(List<ProductID> ids);
  Future<Cart> fetchCart();
  Future<void> setCart(Cart cart);
}