import 'package:bloc/bloc.dart';
import 'package:fl_bloc/business/bloc/events/auth_events.dart';
import 'package:fl_bloc/business/bloc/states/auth_state.dart';
import 'package:fl_bloc/common/error_response.dart';

import '../../../common/auth_error.dart';
import '../../application/app_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppService _service;
  AuthBloc(this._service) : super(const AuthState.initial()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthConsumeError>(_onConsumeError);
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.inProgress));
    try {
      final user = await _service.login(event.name, event.pass);
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } on ErrorResponse catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: AuthError(e.message)));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.inProgress));
    try {
      final user = await _service.register(event.name, event.pass);
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } on ErrorResponse catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error, error: AuthError(e.message)));
    }
  }

  void _onConsumeError(AuthConsumeError event, Emitter<AuthState> emit) {
    if (state.status == AuthStatus.error) {
      emit(state.copyWith(status: AuthStatus.noAuth, user: null, error: null));
    }
  }
}
