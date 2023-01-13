import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/store_service.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/product.dart';

class ProductListingModel extends StateNotifier<AsyncValue<List<Product>>> {
  final StoreService _storeService;

  ProductListingModel(this._storeService) : super(const AsyncValue.loading()) {
    fetchStoreProducts();
  }

  Future<void> fetchStoreProducts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _storeService.fetchAllProducts());
  }
}

final storeListingProvider = StateNotifierProvider.autoDispose<
        ProductListingModel, AsyncValue<List<Product>>>(
    (ref) => ProductListingModel(ref.read(storeServiceProvider)));
