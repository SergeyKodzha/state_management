import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/state.dart';


import 'view.dart';
import 'reducer.dart';
import 'effect.dart';

class OrdersTabComponent extends Component<OrdersState> {
  OrdersTabComponent()
      : super(
      effect: buildEffect(),
      reducer: buildReducer(),
      view: buildView);

}
