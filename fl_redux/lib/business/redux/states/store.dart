import '../../entities/product.dart';

enum StoreState{idle,loading,loaded}
class StoreTabData{
  final StoreState state;
  final List<Product> products;

  const StoreTabData({required this.products, required this.state});
  StoreTabData.initial():products=[],state=StoreState.idle;
  StoreTabData copyWith({List<Product>? products, StoreState? state})=>StoreTabData(products: products??this.products, state: state??this.state);
}