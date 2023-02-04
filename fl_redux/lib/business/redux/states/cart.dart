import '../../entities/cart.dart';
import '../../entities/product.dart';

enum CartState { idle, loading, updating }

class CartTabData {
  final CartState state;
  final Cart cart;
  final Map<ProductID, Product> products;

  CartTabData(
      {required this.state, required this.cart, required this.products});
  CartTabData.initial()
      : state = CartState.idle,
        cart = Cart(const []),
        products = {};

  CartTabData copyWith(
          {CartState? state, Cart? cart, Map<ProductID, Product>? products}) =>
      CartTabData(
          state: state ?? this.state,
          cart: cart ?? this.cart,
          products: products ?? this.products);
}
