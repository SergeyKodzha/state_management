import 'package:flutter/material.dart';

class CartButtonLoading extends StatelessWidget {
  const CartButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 8),
      child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            color: Colors.white,
          )),
    );
  }
}
