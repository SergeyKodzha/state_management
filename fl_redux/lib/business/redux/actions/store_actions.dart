import '../../entities/product.dart';

class StoreAction {}

class StoreLoadingAction implements StoreAction {}

class StoreLoadAction implements StoreAction {}

class StoreLoadedAction implements StoreAction {
  final List<Product> products;

  const StoreLoadedAction(this.products);
}
