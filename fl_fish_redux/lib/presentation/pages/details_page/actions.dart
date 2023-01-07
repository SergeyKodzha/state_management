import 'package:fish_redux/fish_redux.dart';

import '../../../business/entities/cart_item.dart';

enum DetailsAction{updateItem,leave,setEnabled,setEnabledInternal,updated,updatedInternal,goToCart}
class DetailsActions{
  static Action setEnabled(bool enabled)=>Action(DetailsAction.setEnabled,payload: enabled);
  static Action setEnabledInternal(bool enabled)=>Action(DetailsAction.setEnabledInternal,payload: enabled);
  static Action updateItem(CartItem item)=>Action(DetailsAction.updateItem,payload: item);
  static Action updated(CartItem item)=>Action(DetailsAction.updated,payload: item);
  static Action updatedInternal(CartItem item)=>Action(DetailsAction.updatedInternal,payload: item);
  static Action leave()=>const Action(DetailsAction.leave);
  static Action goToCart()=>const Action(DetailsAction.goToCart);
}