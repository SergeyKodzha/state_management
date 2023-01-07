import '../../entities/cart.dart';
import '../../entities/product.dart';

class CartData{
  final Cart cart;
  final Map<ProductID,Product> products;

  CartData({required this.cart, required this.products});
}