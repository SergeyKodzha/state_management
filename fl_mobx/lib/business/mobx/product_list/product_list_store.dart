import 'package:fl_mobx/business/mobx/product_list/store_data.dart';
import 'package:mobx/mobx.dart';

import '../../application/app_service.dart';
import '../../entities/product.dart';

part 'product_list_store.g.dart';

class ProductListStore extends _ProductListStore with _$ProductListStore {
  ProductListStore(super.service);
}
enum StoreTabState{idle,loading}
abstract class _ProductListStore with Store {
    final AppService _service;
    _ProductListStore(this._service);

    @observable
    ObservableFuture<List<Product>>? _dataFuture;

    @observable
    List<Product>? products;


    @computed
    StoreTabState get state {
      final future=_dataFuture;
      if (future!=null) {
        if (future.status == FutureStatus.rejected || future.status==FutureStatus.fulfilled) {
          return StoreTabState.idle;
        } else {
          return StoreTabState.loading;
        }
      } else {
        return StoreTabState.idle;
      }
    }

    @action
    Future<void> fetchProducts() async {
        _dataFuture=ObservableFuture(_service.fetchAllProducts());
        products=await _dataFuture;
    }
}