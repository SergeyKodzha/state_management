import 'package:flutter/material.dart';

import '../../common/error_response.dart';
import '../../common/error.dart';
import '../entities/user.dart';
import 'app_service.dart';
enum AuthState{idle,busy}
class AuthController extends ChangeNotifier{
  AuthState _state=AuthState.idle;

  AuthState get state=>_state;
  //
  Error? _error;
  Error? get error=> _error;
  //
  bool _isBusy=false;
  bool get isBusy=>_isBusy;
  //
  User? _user;
  User? get user=>_user;
  //
  final AppService _appService;

  AuthController(this._appService);

  void consumeError(){
    _error=null;
  }
  Future<void> login(String name,String pass) async {
    consumeError();
    _state=AuthState.busy;
    notifyListeners();
    try {
      _user = await _appService.login(name, pass);
    } on ErrorResponse catch(e){
      _error=Error(e.message);
    } on Exception catch(e){
      _error=Error(e.toString());
    } finally{
      _state=AuthState.idle;
    }
    notifyListeners();
  }

  Future<void> register(String name,String pass) async {
    consumeError();
    _state=AuthState.busy;
    notifyListeners();
    try {
      _user = await _appService.register(name, pass);
    } on ErrorResponse catch(e){
      _error=Error(e.message);
    } on Exception catch(e){
      _error=Error(e.toString());
    } finally{
      _state=AuthState.idle;
    }
    notifyListeners();
  }
}