import 'package:flutter/material.dart';

class StoreLoading extends StatelessWidget {
  const StoreLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
    child: CircularProgressIndicator(),
    );
  }
}
