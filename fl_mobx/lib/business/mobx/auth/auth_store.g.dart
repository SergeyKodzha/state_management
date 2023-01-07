// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<AuthState>? _$stateComputed;

  @override
  AuthState get state => (_$stateComputed ??=
          Computed<AuthState>(() => super.state, name: '_AuthStore.state'))
      .value;

  late final _$authAtom = Atom(name: '_AuthStore.auth', context: context);

  @override
  AuthData? get auth {
    _$authAtom.reportRead();
    return super.auth;
  }

  @override
  set auth(AuthData? value) {
    _$authAtom.reportWrite(value, super.auth, () {
      super.auth = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AuthStore.error', context: context);

  @override
  AuthError? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(AuthError? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$_authFutureAtom =
      Atom(name: '_AuthStore._authFuture', context: context);

  @override
  ObservableFuture<User>? get _authFuture {
    _$_authFutureAtom.reportRead();
    return super._authFuture;
  }

  @override
  set _authFuture(ObservableFuture<User>? value) {
    _$_authFutureAtom.reportWrite(value, super._authFuture, () {
      super._authFuture = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<void> login(String name, String pass) {
    return _$loginAsyncAction.run(() => super.login(name, pass));
  }

  late final _$registerAsyncAction =
      AsyncAction('_AuthStore.register', context: context);

  @override
  Future<void> register(String name, String pass) {
    return _$registerAsyncAction.run(() => super.register(name, pass));
  }

  @override
  String toString() {
    return '''
auth: ${auth},
error: ${error},
state: ${state}
    ''';
  }
}
