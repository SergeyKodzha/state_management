import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/Cart.dart';

class FetchCartController extends StateNotifier<AsyncValue<Cart>> {
  final StoreService _storeService;

  FetchCartController(this._storeService) : super(const AsyncValue.loading()) {
    fetch();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _storeService.fetchCart());
  }

  void updateState(Cart cart) {
    state = AsyncValue.data(cart);
  }
}

final cartProvider =
    StateNotifierProvider.autoDispose<FetchCartController, AsyncValue<Cart>>(
        (ref) => FetchCartController(ref.watch(storeServiceProvider)));
