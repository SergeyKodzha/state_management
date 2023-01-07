import 'package:fl_mobx/business/mobx/cart/cart_store.dart';
import 'package:fl_mobx/business/mobx/order/order_store.dart';
import 'package:fl_mobx/business/mobx/product_list/product_list_store.dart';
import 'package:fl_mobx/presentation/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business/mobx/auth/auth_store.dart';
import 'injector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appService=Injector.instance.appService;
    final authStore=AuthStore(appService);
    final productStore=ProductListStore(appService);
    final cartStore=CartStore(appService);
    final orderStore=OrderStore(appService, cartStore);
    return MultiProvider(
      providers: [
        Provider<AuthStore>(create:(context) => authStore,),
        Provider<ProductListStore>(create:(context) => productStore, ),
        Provider<CartStore>(create:(context) => cartStore, ),
        Provider<OrderStore>(create:(context) => orderStore, ),
      ],
      builder:(_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}