import 'auth.dart';
import 'cart.dart';
import 'orders.dart';
import 'store.dart';

class AppState{
  final AuthData authData;
  final StoreTabData storeData;
  final CartTabData cartData;
  final OrdersTabData ordersData;
  AppState({required this.authData,required this.storeData,required this.cartData,required this.ordersData});
  AppState.initial():authData=AuthData.initial(),storeData=StoreTabData.initial(),cartData=CartTabData.initial(),ordersData=OrdersTabData.initial();
  AppState copyWith({AuthData? authData,StoreTabData? storeData,CartTabData? cart,OrdersTabData? ordersData})=>AppState(authData: authData??this.authData,storeData: storeData??this.storeData,cartData:cart??cartData,ordersData: ordersData??this.ordersData);
}