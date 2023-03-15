import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/injector.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/actions.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/state.dart';
import 'package:flutter/material.dart' hide Action;

import '../../../common/error_response.dart';

Effect<AuthState> buildEffect() {
  return combineEffects({
    AuthAction.login:_login,
    AuthAction.register:_register,
    AuthAction.error:_error,
    AuthAction.leave:_leave,
  });
}

void _login(Action action, Context<AuthState> context) async {
  context.dispatch(AuthActions.processing());
  final data=action.payload as Map<String,dynamic>;
  try {
    final service=Injector.instance.appService;
    final user = await service.login(data['name'], data['pass']);
    context.dispatch(AuthActions.leave(user));
  } on ErrorResponse catch(e){
    context.dispatch(AuthActions.error(e.message));
  }
}


void _register(Action action, Context<AuthState> context) async {
  context.dispatch(AuthActions.processing());
  final data=action.payload as Map<String,dynamic>;
  try {
    final service=Injector.instance.appService;
    final user = await service.register(data['name'], data['pass']);
    context.dispatch(AuthActions.leave(user));
  } on ErrorResponse catch(e){
    context.dispatch(AuthActions.error(e.message));
  }
  }

void _error(Action action, Context<AuthState> context) {
  ScaffoldMessenger.of(context.context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.red,
        content: SizedBox(height: 20, child: Center(child: Text(action.payload)))),
  );
  context.dispatch(AuthActions.idle());
}

void _leave(Action action, Context<AuthState> context) async {
  Navigator.of(context.context).pop(action.payload);
}
