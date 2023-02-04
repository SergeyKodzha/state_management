import 'package:fl_redux/business/application/app_service.dart';

import 'package:redux/redux.dart';

import '../../../../common/auth_error.dart';
import '../../../../common/error_response.dart';
import '../actions/auth_actions.dart';
import '../states/app_state.dart';

class AuthMiddleware extends MiddlewareClass<AppState>{
  final AppService _service;

  AuthMiddleware(this._service);
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AuthLoginAction){
      store.dispatch(AuthInProgressAction());
      try {
        final user=await _service.login(action.name, action.pass);
        store.dispatch(AuthLoggedAction(user));
      } on ErrorResponse catch(e){
        store.dispatch(AuthErrorAction(AuthError(e.message)));
      }
    } else if (action is AuthRegisterAction){
      store.dispatch(AuthInProgressAction());
      try {
        final user=await _service.register(action.name, action.pass);
        store.dispatch(AuthLoggedAction(user));
      } on ErrorResponse catch(e){
        store.dispatch(AuthErrorAction(AuthError(e.message)));
      }
    }
    next(action);
  }

}