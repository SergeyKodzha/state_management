import '../../../../common/auth_error.dart';
import '../../entities/user.dart';

class AuthAction {}

class AuthLoginAction implements AuthAction {
  final String name;
  final String pass;

  const AuthLoginAction(this.name, this.pass);
}

class AuthRegisterAction implements AuthAction {
  final String name;
  final String pass;

  const AuthRegisterAction(this.name, this.pass);
}

class AuthErrorAction implements AuthAction {
  final AuthError error;

  const AuthErrorAction(this.error);
}

class AuthInProgressAction implements AuthAction {}

class AuthNotLoggedAction implements AuthAction {}

class AuthLoggedAction implements AuthAction {
  final User user;

  const AuthLoggedAction(this.user);
}
