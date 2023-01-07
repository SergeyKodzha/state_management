
import 'package:fish_redux/fish_redux.dart';

import 'actions.dart';
import 'state.dart';

Reducer<AuthState> buildReducer(){
  return asReducer({
    AuthAction.idle:(state,action)=>state.clone()..status=state.user==null?AuthStatus.loggedOut:AuthStatus.loggedIn,
    AuthAction.processing:(state,action)=>state.clone()..status=AuthStatus.processing,
  });
}