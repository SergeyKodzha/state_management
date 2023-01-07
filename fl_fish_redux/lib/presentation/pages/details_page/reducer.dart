import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/details_page/actions.dart';

import 'state.dart';

Reducer<DetailsState> buildReducer() {
  return asReducer({
    DetailsAction.setEnabledInternal: (state, action) {
      return state.clone()
        ..status = action.payload == true
            ? DetailsStatus.enabled
            : DetailsStatus.disabled;
    },
    DetailsAction.updatedInternal:(state, action) {
      return state.clone()
      ..status=DetailsStatus.enabled
      ..cartItem=action.payload;
    }
  });
}
