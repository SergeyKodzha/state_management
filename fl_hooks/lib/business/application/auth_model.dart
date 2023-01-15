import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/error_response.dart';
import '../../common/hook_data_container.dart';
import '../../common/ui_error.dart';
import '../entities/user.dart';
import 'app_service.dart';

class AuthModel extends HookDataContainer<User> {
  final AppService _service;

  AuthModel(this._service);

  void login(String name, String pass) async {
    state.value = HookDataState.loading;
    try {
      final data = await _service.login(name, pass);
      setData(data);
    } on ErrorResponse catch (e) {
      setError(UIError(e.message));
    } catch (e) {
      setError(UIError(e.toString()));
    }
  }

  void register(String name, String pass) async {
    state.value = HookDataState.loading;
    try {
      final data = await _service.register(name, pass);
      setData(data);
    } on ErrorResponse catch (e) {
      setError(UIError(e.message));
    } catch (e) {
      setError(UIError(e.toString()));
    }
  }
}

AuthModel useAuthController(AppService service) {
  final controller = useState(AuthModel(service)).value;
  useListenable<ValueNotifier<HookDataState>>(controller.state);
  return controller;
}
