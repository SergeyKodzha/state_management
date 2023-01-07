
import 'package:redux/redux.dart';

import 'actions/auth_actions.dart';
import 'actions/cart_actions.dart';
import 'actions/order_actions.dart';
import 'actions/store_actions.dart';
import 'states/app_state.dart';
import 'states/auth.dart';
import 'states/cart.dart';
import 'states/orders.dart';
import 'states/store.dart';

final appReducer=combineReducers<AppState>(
  [
    //auth
    TypedReducer<AppState,AuthInProgressAction>(_authInProgress),
    TypedReducer<AppState,AuthErrorAction>(_authError),
    TypedReducer<AppState,AuthLoggedAction>(_authSuccess),
    TypedReducer<AppState,AuthNotLoggedAction>(_authNoAuth),
    //store
    TypedReducer<AppState,StoreLoadingAction>(_storeLoading),
    TypedReducer<AppState,StoreLoadedAction>(_storeLoaded),
    //cart
    TypedReducer<AppState,CartLoadingAction>(_cartLoading),
    TypedReducer<AppState,CartLoadedAction>(_cartLoaded),
    TypedReducer<AppState,CartUpdatingAction>(_cartUpdating),
    TypedReducer<AppState,CartUpdatedAction>(_cartUpdated),
    //orders
    TypedReducer<AppState,OrdersLoadingAction>(_ordersLoading),
    TypedReducer<AppState,OrdersLoadedAction>(_ordersLoaded),
      TypedReducer<AppState,OrderingAction>(_orderInProgress),
      TypedReducer<AppState,OrderCreatedAction>(_orderCreated),
  ]
);
//auth
AppState _authInProgress(AppState state, AuthInProgressAction action)=>state.copyWith(authData: state.authData.copyWith(state: AuthState.inProgress));

AppState _authError(AppState state, AuthErrorAction action)=>state.copyWith(authData: state.authData.copyWith(state: AuthState.error,error: action.error));

AppState _authSuccess(AppState state, AuthLoggedAction action)=>state.copyWith(authData: state.authData.copyWith(state: AuthState.authed,user: action.user,error: null));

AppState _authNoAuth(AppState state, AuthNotLoggedAction action)=>state.copyWith(authData: state.authData.copyWith(state: AuthState.noAuth,user: null,error: null));

//store
AppState _storeLoading(AppState state, StoreLoadingAction action)=> state.copyWith(storeData: state.storeData.copyWith(state: StoreState.loading));

AppState _storeLoaded(AppState state, StoreLoadedAction action)=>state.copyWith(storeData: state.storeData.copyWith(state: StoreState.loaded,products: action.products));

//cart
AppState _cartLoading(AppState state, CartLoadingAction action)=> state.copyWith(cart: state.cartData.copyWith(state:CartState.loading));

AppState _cartLoaded(AppState state, CartLoadedAction action)=> state.copyWith(cart: state.cartData.copyWith(state:CartState.idle,cart: action.cart,products: action.products));

AppState _cartUpdating(AppState state, CartUpdatingAction action)=> state.copyWith(cart: state.cartData.copyWith(state:CartState.updating));

AppState _cartUpdated(AppState state, CartUpdatedAction action)=> state.copyWith(cart: state.cartData.copyWith(state:CartState.idle,cart: action.cart));

//orders
AppState _orderInProgress(AppState state, OrderingAction action)=> state.copyWith(ordersData: state.ordersData.copyWith(state:OrdersState.ordering));
AppState _orderCreated(AppState state, OrderCreatedAction action)=> state.copyWith(ordersData: state.ordersData.copyWith(state:OrdersState.idle,orders: action.orders));
AppState _ordersLoading(AppState state, OrdersLoadingAction action)=> state.copyWith(ordersData: state.ordersData.copyWith(state:OrdersState.loading));

AppState _ordersLoaded(AppState state, OrdersLoadedAction action)=> state.copyWith(ordersData: state.ordersData.copyWith(state:OrdersState.idle,orders: action.orders));