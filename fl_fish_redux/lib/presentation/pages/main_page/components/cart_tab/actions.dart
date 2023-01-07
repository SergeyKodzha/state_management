
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart_item.dart';
import 'package:fl_fish_redux/business/entities/product.dart';

import '../../../../../business/entities/cart.dart';

enum CartAction{load,loading,loaded,updating,updatingInternal,setItem,removeItem}
class CartActions{
  static Action load()=>const Action(CartAction.load);
  static Action loading()=>const Action(CartAction.loading);
  static Action loaded(Cart cart,Map<ProductID,Product> products)=>Action(CartAction.loaded,payload: {'cart':cart,'products':products});
  static Action updating()=>const Action(CartAction.updating);
  static Action updatingInternal()=>const Action(CartAction.updatingInternal);
  static Action setItem(CartItem item)=>Action(CartAction.setItem,payload: item);
  static Action removeItem(ProductID id)=>Action(CartAction.removeItem,payload: id);
}