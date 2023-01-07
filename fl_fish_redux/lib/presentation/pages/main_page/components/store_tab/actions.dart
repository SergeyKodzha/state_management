import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/product.dart';

import '../../../../../business/entities/cart_item.dart';

enum StoreActon{load,loading,loaded,productTap}
class StoreActions{
  static Action load()=>const Action(StoreActon.load);
  static Action loading()=>const Action(StoreActon.loading);
  static Action loaded(List<Product> products)=>Action(StoreActon.loaded,payload: products);
  static Action productTap(Product product)=> Action(StoreActon.productTap,payload: product);
}