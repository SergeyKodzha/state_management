import 'package:equatable/equatable.dart';

import '../../entities/cart.dart';
import '../../entities/product.dart';

enum CartStatus { idle, loading, busy }

class CartState extends Equatable {
  final CartStatus status;
  final Cart cart;
  final Map<ProductID, Product> products;

  CartState({required this.status, required this.cart, required this.products});
  CartState.initial()
      : status = CartStatus.idle,
        cart = Cart(const []),
        products = {};
  CartState copyWith(
          {CartStatus? status,
          Cart? cart,
          Map<ProductID, Product>? products}) =>
      CartState(
          status: status ?? this.status,
          cart: cart ?? this.cart,
          products: products ?? this.products);

  @override
  List<Object?> get props => [status, cart, products];
}
