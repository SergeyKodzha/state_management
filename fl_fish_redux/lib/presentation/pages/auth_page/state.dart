import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/injector.dart';
import '../../../business/entities/user.dart';

enum AuthStatus { loggedOut, processing, loggedIn }

class AuthState implements Cloneable<AuthState> {
  AuthStatus status = AuthStatus.loggedOut;
  User? user;
  //AuthError? error;
  @override
  AuthState clone() {
    return AuthState()
      ..user = user
      ..status = status;
  }

  static AuthState initState() {
    final user = Injector.instance.appService.currentUser;

    return AuthState()
      ..user = user
      ..status = user == null ? AuthStatus.loggedOut : AuthStatus.loggedIn;
  }
}
