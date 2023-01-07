import 'package:equatable/equatable.dart';
import '../../../../../business/entities/product.dart';
import '../../../../../business/redux/states/store.dart';

class StoreTabViewModel extends Equatable{
  final StoreState state;
  final List<Product> products;
  StoreTabViewModel(this.state, this.products);

  @override
  // TODO: implement props
  List<Object?> get props =>[state,products];
}