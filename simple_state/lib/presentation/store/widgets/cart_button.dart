import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final String? superscript;
  final VoidCallback onPressed;
  const CartButton({Key? key, this.superscript, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return superscript == null
        ? Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: onPressed,
              )
            ],
          )
        : Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: onPressed,
              ),
              Positioned(
                  right: 8,
                  top: 0,
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        superscript!,
                        style: const TextStyle(fontSize: 12),
                      )),
                    ),
                  )),
            ],
          );
  }
}
