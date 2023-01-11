import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';

class StoreItem extends StatelessWidget {
  final Product product;
  final void Function(Product)? onTap;

  const StoreItem({Key? key, required this.product, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(product),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/${product.image}',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.1),
              thickness: 1,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                )),
            const SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(product.description)),
            const SizedBox(
              height: 16,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text('${product.price.toString()} руб')),
            const SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'в наличие ${product.available} шт',
                  style: TextStyle(color: Colors.black.withOpacity(0.25)),
                )),
          ]),
        ),
      ),
    );
  }
}
