import 'package:fl_bloc/business/bloc/blocs/auth_bloc.dart';
import 'package:fl_bloc/business/bloc/blocs/cart_bloc.dart';
import 'package:fl_bloc/business/bloc/blocs/order_bloc.dart';
import 'package:fl_bloc/business/bloc/blocs/store_bloc.dart';
import 'package:fl_bloc/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/main_page/main_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
        BlocProvider(
          create: (context) => storeBloc,
        ),
        BlocProvider(
          create: (context) => cartBloc,
        ),
        BlocProvider(
          create: (context) => orderBloc,
        ),
      ],
      child: MaterialApp(
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
