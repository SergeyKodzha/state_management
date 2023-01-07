import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/state.dart';

import 'effect.dart';
import 'view.dart';
import 'reducer.dart';

class StoreTabComponent extends Component<StoreState> {
  StoreTabComponent()
      : super(
    effect: buildEffect(),
    reducer: buildReducer(),
    view: buildView);
}
