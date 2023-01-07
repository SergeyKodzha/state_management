import 'package:fl_mobx/business/application/app_service.dart';
import 'package:fl_mobx/business/mobx/auth/auth_data.dart';
import 'package:mobx/mobx.dart';

import '../../../common/auth_error.dart';
import '../../../common/error_response.dart';
import '../../entities/user.dart';

part 'auth_store.g.dart';

enum AuthState{idle,loading}
class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(super.service);
}

abstract class _AuthStore with Store {
    final AppService _service;

    _AuthStore(this._service);

    @observable
    AuthData? auth;

    @observable
    AuthError? error;

    @observable
    ObservableFuture<User>? _authFuture;

    @computed
    AuthState get state {
        final future=_authFuture;
        if (future!=null) {
            if (future.status == FutureStatus.rejected || future.status==FutureStatus.fulfilled) {
                return AuthState.idle;
            } else {
                return AuthState.loading;
            }
        } else {
          return AuthState.idle;
        }
    }

    @action
    Future<void> login(String name,String pass) async {
        try {
            error=null;
            _authFuture=ObservableFuture(_service.login(name, pass));
            final user=await _authFuture;
            auth=AuthData(user);
        } on ErrorResponse catch(e){
            error=AuthError(e.message);
        }
    }

    @action
    Future<void> register(String name,String pass) async {
        try {
            error=null;
            _authFuture=ObservableFuture(_service.register(name, pass));
            final user=await _authFuture;
            auth=AuthData(user);
        } on ErrorResponse catch(e){
            error=AuthError(e.message);
        }
    }
}