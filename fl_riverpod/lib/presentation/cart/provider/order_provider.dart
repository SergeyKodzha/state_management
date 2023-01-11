import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/order.dart';

class OrderController extends StateNotifier<AsyncValue<Order?>> {
  final StoreService _service;
  bool _isOrdering = false;

  bool get isOrdering => _isOrdering;

  OrderController(this._service) : super(const AsyncValue.data(null)) {
    fetchOrder();
  }

  void fetchOrder() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _service.fetchOrder());
  }

  void order() async {
    print('ordering');
    state = const AsyncValue.loading();
    _isOrdering = true;
    try {
      state = AsyncValue.data(await _service.order());
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isOrdering = false;
    }
  }
}

final orderProvider =
    StateNotifierProvider.autoDispose<OrderController, AsyncValue<Order?>>(
        (ref) => OrderController(ref.read(storeServiceProvider)));
