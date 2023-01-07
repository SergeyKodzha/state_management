import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/product.dart';

class RemoveCartItemController extends StateNotifier<AsyncValue<void>>{
  final StoreService _storeService;
  RemoveCartItemController(this._storeService):super(const AsyncValue.data(null));
  Future<void> removeCartItem(ProductID id) async {
    state=const AsyncValue.loading();
    await _storeService.removeCartItem(id);
    state=const AsyncValue.data(null);
  }
}

final removeCartItemProvider=StateNotifierProvider.autoDispose<RemoveCartItemController,AsyncValue<void>>((ref) => RemoveCartItemController(ref.read(storeServiceProvider)));