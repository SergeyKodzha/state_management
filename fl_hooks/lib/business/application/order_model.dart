import 'package:fl_hooks/business/application/app_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/hook_data_container.dart';
import '../entities/order.dart';

class OrderModel extends HookDataContainer<Order?> {
  final AppService _service;

  OrderModel(this._service);
  Future<void> fetchOrder() async {
    state.value = HookDataState.loading;
    final order = await _service.fetchOrder();
    setData(order);
  }

  Future<void> order() async {
    state.value = HookDataState.loading;
    final order = await _service.order();
    setData(order);
  }
}

OrderModel useOrderController(AppService service) {
  final controller = useState<OrderModel>(OrderModel(service)).value;
  useListenable(controller.state);
  return controller;
}
