import 'package:fish_redux/fish_redux.dart';

import '../../../business/entities/cart_item.dart';
import '../../../business/entities/product.dart';
enum DetailsStatus{enabled, disabled}
class DetailsState extends Cloneable<DetailsState>{
  Product product;
  CartItem cartItem;
  DetailsStatus status=DetailsStatus.enabled;
  DetailsState(this.product,CartItem item):cartItem=item;
  @override
  DetailsState clone() {
    return DetailsState(product,cartItem)..status=status;
  }

}