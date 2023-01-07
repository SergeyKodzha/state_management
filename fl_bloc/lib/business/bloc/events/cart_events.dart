import 'package:equatable/equatable.dart';
import 'package:fl_bloc/business/entities/cart_item.dart';

import '../../entities/product.dart';

abstract class CartEvent extends Equatable{}
class CartFetchData extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CartUpdateItem extends CartEvent{
  final CartItem item;

  CartUpdateItem(this.item);
  @override
  // TODO: implement props
  List<Object?> get props => [item];
}

class CartRemoveItem extends CartEvent{
  final ProductID productId;

  CartRemoveItem(this.productId);

  @override
  // TODO: implement props
  List<Object?> get props => [productId];

}