
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/component.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/view.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/effect.dart';

import 'components/cart_tab/component.dart';
import 'components/orders_tab/state.dart';
import 'components/store_tab/component.dart';
import 'components/store_tab/state.dart';
import 'reducer.dart';
import 'state.dart';

class MainPage extends Page<MainState,void> with SingleTickerProviderMixin{
  MainPage():super(
      initState: (_)=>MainState(),
      reducer: buildReducer(),
      effect: buildEffect(),
      view: buildPage,
    dependencies: Dependencies(
      slots: {
        'store':StoreConnector()+StoreTabComponent(),
        'cart':CartConnector()+CartTabComponent(),
        'orders':OrdersConnector()+OrdersTabComponent(),
      },
    ),
  );
}