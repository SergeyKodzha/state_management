import 'package:fl_streams/common/error_response.dart';
import '../../../common/auth_error.dart';
import '../../../common/custom_bloc/custom_bloc.dart';
import '../../application/app_service.dart';
import '../events/auth_events.dart';
import '../states/auth_state.dart';

class AuthBloc extends CustomBloc<AuthEvent, AuthState> {
  final AppService _service;
  AuthBloc(this._service) : super(const AuthState.initial());
  @override
  void handleEvent(AuthEvent event) {
    if (event is AuthLogin) {
      _onLogin(event);
    } else if (event is AuthRegister) {
      _onRegister(event);
    } else if (event is AuthConsumeError) {
      _onConsumeError(event);
    }
  }

  void _onLogin(AuthLogin event) async {
    emit(state.copyWith(status: AuthStatus.inProgress));
    try {
      final user = await _service.login(event.name, event.pass);
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } on ErrorResponse catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: AuthError(e.message)));
    }
  }

  void _onRegister(AuthRegister event) async {
    emit(state.copyWith(status: AuthStatus.inProgress));
    try {
      final user = await _service.register(event.name, event.pass);
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } on ErrorResponse catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: AuthError(e.message)));
    }
  }

  void _onConsumeError(AuthConsumeError event) {
    if (state.status == AuthStatus.error) {
      emit(state.copyWith(status: AuthStatus.noAuth, user: null, error: null));
    }
  }
}
