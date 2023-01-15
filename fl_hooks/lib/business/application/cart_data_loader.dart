import 'package:fl_hooks/business/application/app_service.dart';
import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../entities/cart.dart';
import '../entities/product.dart';

class CartDataLoader extends HookDataContainer<Map<ProductID, Product>> {
  final AppService _service;
  CartDataLoader(this._service);
  Future<void> fetchCartProducts(Cart cart) async {
    await Future.delayed(Duration(seconds: 2));
    state.value = HookDataState.loading;
    final List<ProductID> ids = [];
    for (final item in cart.items) {
      ids.add(item.productId);
    }
    final products = await _service.fetchCartProducts(ids);
    setData(products);
  }
}

CartDataLoader useCartDataLoader(AppService service) {
  final loader = useState<CartDataLoader>(CartDataLoader(service)).value;
  useListenable(loader.state);
  return loader;
}
