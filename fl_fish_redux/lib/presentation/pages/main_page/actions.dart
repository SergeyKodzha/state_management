
import 'package:fish_redux/fish_redux.dart';

import '../../../business/entities/product.dart';
import '../../../business/entities/user.dart';

enum MainPageAction{action,login,setUser,showDetails,showTab,order}
class MainPageActions{
  static Action action()=>const Action(MainPageAction.action);
  static Action login()=>const Action(MainPageAction.login);
  static Action showTab(int tab)=>Action(MainPageAction.showTab,payload: tab);
  static Action setUser(User? user)=>Action(MainPageAction.setUser,payload: user);
  static Action showDetails(Product product)=>Action(MainPageAction.showDetails,payload:product);
  static Action order()=>const Action(MainPageAction.order);
}