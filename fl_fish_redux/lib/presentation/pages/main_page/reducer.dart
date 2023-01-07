
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';

import 'state.dart';

Reducer<MainState> buildReducer(){
  return asReducer({
    MainPageAction.setUser:(state,action) {
      return state.clone()..user=action.payload;
    },
    MainPageAction.action:(state,action) {
      return state.clone();
    },
  });
}