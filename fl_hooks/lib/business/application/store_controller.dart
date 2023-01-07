import 'package:fl_hooks/business/application/app_service.dart';
import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../entities/product.dart';
class StoreController extends HookDataContainer<List<Product>>{
  final AppService _service;
  StoreController(this._service);

  void fetchAllProducts() async {
    state.value=HookDataState.loading;
    final products=await _service.fetchAllProducts();
    setData(products);
  }
}

StoreController useStoreController(AppService service){
  final controller=useState(StoreController(service)).value;
  useListenable<ValueNotifier<HookDataState>>(controller.state);
  return controller;
}