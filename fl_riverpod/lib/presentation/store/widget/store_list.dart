import 'package:fl_riverpod/presentation/store/widget/store_item.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';

class StoreList extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onTap;
  const StoreList({Key? key, required this.products, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 40 / 57,
      ),
      itemBuilder: (context, index) {
        return StoreItem(
          product: products[index],
          onTap: (product) {
            onTap(product);
            /*
            CartItem item = CartItem(product.id, 0);
            for (final i in cart.items) {
              if (i.productId == product.id) {
                item = i;
                break;
              }
            }
            _navigateToDetailsPage(product, item);
             */
          },
        );
      },
    );
  }
}
