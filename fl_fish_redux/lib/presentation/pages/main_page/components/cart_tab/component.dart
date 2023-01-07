import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';

import 'reducer.dart';
import 'effect.dart';
import 'view.dart';

class CartTabComponent extends Component<CartState> {
  CartTabComponent()
      : super(
      effect: buildEffect(),
      reducer: buildReducer(),
      view: buildView);

}
