

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/error_response.dart';
import '../../common/hook_data_container.dart';
import '../../common/ui_error.dart';
import '../entities/user.dart';
import 'app_service.dart';

class AuthController extends HookDataContainer<User>{
  final AppService _service;

  AuthController(this._service);

  void login(String name,String pass) async {
    state.value=HookDataState.loading;
    try {
      final data = await _service.login(name, pass);
      setData(data);
    } on ErrorResponse catch(e){
      setError(UIError(e.message));
    } catch(e){
      setError(UIError(e.toString()));
    }
  }

  void register(String name,String pass) async {
    state.value=HookDataState.loading;
    try {
      final data = await _service.register(name, pass);
      setData(data);
    }  on ErrorResponse catch(e){
      setError(UIError(e.message));
    } catch(e){
      setError(UIError(e.toString()));
    }
  }
}

AuthController useAuthController(AppService service){
  final controller=useState(AuthController(service)).value;
  useListenable<ValueNotifier<HookDataState>>(controller.state);
  return controller;
}