
import 'package:fl_redux/injector.dart';
import 'package:fl_redux/presentation/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'business/redux/middlewares/auth_middleware.dart';
import 'business/redux/middlewares/cart_middleware.dart';
import 'business/redux/middlewares/orders_middleware.dart';
import 'business/redux/middlewares/store_middleware.dart';
import 'business/redux/reducer.dart';
import 'business/redux/states/app_state.dart';

void main() {
  final appSevice = Injector.instance.appService;
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [
        AuthMiddleware(appSevice),
        StoreMiddleware(appSevice),
        CartMiddleware(appSevice),
        OrdersMiddleware(appSevice),
      ]);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({super.key, required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
