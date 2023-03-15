import '../../../../common/auth_error.dart';
import '../../entities/user.dart';

//auth model
enum AuthState{noAuth,inProgress,error,authed}
class AuthData{
  final AuthState state;
  final User? user;
  final AuthError? error;
  AuthData({required this.state, this.user,this.error});
  AuthData.initial():state=AuthState.noAuth,user=null,error=null;
  AuthData copyWith({AuthState? state,User? user,AuthError? error})=>AuthData(state: state??this.state,user:user??this.user,error:error??this.error);
}