
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'view.dart';

class DetailsPage extends Page<DetailsState,Map<String,dynamic>>{
  DetailsPage():super(
    initState: (params)=>DetailsState(params['product'],params['item']),
    reducer: buildReducer(),
    effect: buildEffect(),
    view: buildPage,
  );
}