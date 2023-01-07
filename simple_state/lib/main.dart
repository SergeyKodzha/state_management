import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business/application/app_service.dart';
import 'business/application/auth_controller.dart';
import 'business/application/cart_controller.dart';
import 'business/application/cart_products_loader.dart';
import 'business/application/order_controller.dart';
import 'business/application/store_controller.dart';
import 'data/repositories/mock_auth_repository.dart';
import 'data/repositories/mock_local_repository.dart';
import 'data/repositories/mock_remote_repository.dart';
import 'presentation/store/store_page.dart';

void main() {
  final service = AppService(
      MockAuthRepository(), MockLocalRepository(), MockRemoteRepository());
  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  final AppService service;
  const MyApp({super.key, required this.service});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => service,),
        ChangeNotifierProvider(
          create: (context) => AuthController(service),
        ),
        ChangeNotifierProvider(
          create: (context) => StoreController(service),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(service),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProductsLoader(service),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderController(service),
        ),
      ],
      child: MaterialApp(
        title: 'Simple State Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(child: StorePage()),
      ),
    );
  }
}
