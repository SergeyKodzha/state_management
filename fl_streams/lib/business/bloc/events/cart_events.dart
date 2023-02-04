import 'package:equatable/equatable.dart';

import '../../entities/cart_item.dart';
import '../../entities/product.dart';

abstract class CartEvent extends Equatable {}

class CartFetchData extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartUpdateItem extends CartEvent {
  final CartItem item;

  CartUpdateItem(this.item);
  @override
  List<Object?> get props => [item];
}

class CartRemoveItem extends CartEvent {
  final ProductID productId;

  CartRemoveItem(this.productId);

  @override
  List<Object?> get props => [productId];
}
