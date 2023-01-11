import 'package:flutter/material.dart';

class CartPreloaderBox extends StatelessWidget {
  const CartPreloaderBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2))
                ],
                borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )),
      ),
    );
  }
}
