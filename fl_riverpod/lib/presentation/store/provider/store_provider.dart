import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/product.dart';

class ProductListingController
    extends StateNotifier<AsyncValue<List<Product>>> {
  final StoreService _storeService;

  ProductListingController(this._storeService)
      : super(const AsyncValue.loading()) {
    fetchStoreProducts();
  }

  Future<void> fetchStoreProducts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _storeService.fetchAllProducts());
  }
}

final storeListingProvider = StateNotifierProvider.autoDispose<
        ProductListingController, AsyncValue<List<Product>>>(
    (ref) => ProductListingController(ref.read(storeServiceProvider)));
