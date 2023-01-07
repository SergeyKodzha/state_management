import 'package:fish_redux/fish_redux.dart';

import '../../../../../business/entities/product.dart';
import '../../state.dart';

enum StoreStatus { initial, loading,loaded }

class StoreState extends Cloneable<StoreState> {
  StoreStatus status = StoreStatus.initial;
  List<Product> products = [];
  @override
  StoreState clone() {
    return StoreState()
      ..products = products
      ..status = status;
  }
}

class StoreConnector extends ConnOp<MainState, StoreState> {
  @override
  StoreState get(MainState state) {
    return state.storeState.clone();
  }
  @override
  void set(MainState state, StoreState subState) {
    state.storeState=subState.clone();
  }
}