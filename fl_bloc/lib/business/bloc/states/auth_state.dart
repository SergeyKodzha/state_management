import 'package:equatable/equatable.dart';

import '../../../common/auth_error.dart';
import '../../entities/user.dart';

enum AuthStatus{noAuth,inProgress,loggedIn,error}

class AuthState extends Equatable{
  final AuthStatus status;
  final User? user;
  final AuthError? error;
  const AuthState({required this.status, required this.user,this.error});
  const AuthState.initial():status=AuthStatus.noAuth,user=null,error=null;
  AuthState copyWith({AuthStatus? status,User? user,AuthError? error})=>AuthState(status: status??this.status,user: user??this.user,error: error??this.error);

  @override
  List<Object?> get props => [status,user,error];
}