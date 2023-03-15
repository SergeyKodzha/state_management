import 'package:equatable/equatable.dart';
import 'package:fl_redux/business/entities/product.dart';

import '../../../../../business/entities/cart.dart';

class CartTabViewModel extends Equatable{
  final Cart cart;
  final Map<ProductID,Product> products;

  const CartTabViewModel(this.cart, this.products);
  @override
  List<Object?> get props => [cart,products];
}