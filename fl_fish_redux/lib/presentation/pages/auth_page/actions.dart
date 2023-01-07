import 'package:fish_redux/fish_redux.dart';
import '../../../business/entities/user.dart';

enum AuthAction{idle,processing,error, login,register,leave}
class AuthActions{
  static Action idle()=>const Action(AuthAction.idle,);
  static Action processing()=>const Action(AuthAction.processing,);
  static Action login(String name,String pass)=>Action(AuthAction.login,payload: {'name':name,'pass':pass});
  static Action register(String name,String pass)=>Action(AuthAction.register,payload: {'name':name,'pass':pass});
  static Action leave(User? user)=>Action(AuthAction.leave,payload: user);
  static Action error(String msg)=>Action(AuthAction.error,payload: msg);
}