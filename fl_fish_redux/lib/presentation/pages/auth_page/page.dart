import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/effect.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/reducer.dart';
import 'state.dart';
import 'view.dart';


class AuthPage extends Page<AuthState,void>{
  AuthPage():super(
      initState: (_)=>AuthState(),
      reducer: buildReducer(),
      effect: buildEffect(),
      /*
      reducer: buildStorePageReducer(),
      dependencies: Dependencies(
        slots: {
          'list':StoreListConnector()+StoreListComponent()
        },
      ),
       */
      view:buildPage,
  );
}