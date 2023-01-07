import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/cart_item.dart';

class SetCartItemController extends StateNotifier<AsyncValue<void>>{
  final StoreService _storeService;
  SetCartItemController(this._storeService):super(const AsyncValue.data(null));
  Future<void> setCartItem(CartItem item) async {
    state=const AsyncValue.loading();
    await _storeService.setCartItem(item);
    state=const AsyncValue.data(null);
  }
}

final setCartItemProvider=StateNotifierProvider.autoDispose<SetCartItemController,AsyncValue<void>>((ref) => SetCartItemController(ref.read(storeServiceProvider)));