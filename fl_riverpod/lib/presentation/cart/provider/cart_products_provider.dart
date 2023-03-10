import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/product.dart';

class CartProductsModel
    extends StateNotifier<AsyncValue<Map<ProductID, Product>>> {
  final StoreService _service;

  CartProductsModel(this._service) : super(const AsyncValue.loading());

  Future<void> fetchCartProducts(List<ProductID> ids) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _service.fetchCartProducts(ids));
  }
}

final cartProductsProvider = StateNotifierProvider.autoDispose<
    CartProductsModel, AsyncValue<Map<ProductID, Product>>>((ref) {
  return CartProductsModel(ref.watch(storeServiceProvider));
});
