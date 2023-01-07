import 'package:fl_hooks/injector.dart';
import 'package:fl_hooks/presentation/auth/auth_page.dart';
import 'package:fl_hooks/presentation/store/store_page.dart';
import 'package:flutter/material.dart';

import 'business/application/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:StorePage(Injector.instance.appService),
    );
  }
}
