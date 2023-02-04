import 'package:fl_streams/presentation/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business/bloc/blocs/auth_bloc.dart';
import 'business/bloc/blocs/cart_bloc.dart';
import 'business/bloc/blocs/order_bloc.dart';
import 'business/bloc/blocs/store_bloc.dart';
import 'injector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Injector.instance.appService;
    final authBloc = AuthBloc(appService);
    final storeBloc = StoreBloc(appService);
    final cartBloc = CartBloc(appService);
    final orderBloc = OrderBloc(appService, cartBloc);
    return MultiProvider(
      providers: [
        Provider<AuthBloc>(
          create: (context) => authBloc,
        ),
        Provider<StoreBloc>(
          create: (context) => storeBloc,
        ),
        Provider<CartBloc>(
          create: (context) => cartBloc,
        ),
        Provider<OrderBloc>(
          create: (context) => orderBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}
