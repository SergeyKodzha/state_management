import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final int? superscript;
  const CartIcon({Key? key, this.superscript}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return superscript == null || superscript==0
        ? const Icon(Icons.shopping_cart)
        : Stack(
      clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),
              Positioned(
                  right: -5,
                  top: -5,
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        superscript.toString(),
                        style: const TextStyle(fontSize: 12),
                      )),
                    ),
                  )),
            ],
          );
  }
}
