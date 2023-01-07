import 'package:fl_mobx/business/mobx/product_list/product_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../../business/entities/product.dart';

import '../../../details_page/details_page.dart';
import 'widgets/store_item.dart';

class StoreTab extends StatelessWidget {
  final VoidCallback _onGoToCart;
  const StoreTab({super.key, required onGoToCart}) : _onGoToCart = onGoToCart;

  @override
  Widget build(BuildContext context) {
    final productStore = context.read<ProductListStore>();
    return Observer(
      builder: (context) {
        return productStore.state == StoreTabState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _productList(productStore.products ?? []);
      },
    );
  }

  void load(BuildContext context) {
    final productStore = context.read<ProductListStore>();
    productStore.fetchProducts();
  }

  Widget _productList(List<Product> products) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 40 / 56,
        ),
        itemBuilder: (context, index) {
          return StoreItem(
            product: products[index],
            onTap: (product) {
              _navigateToDetailsScreen(context, product);
            },
          );
        });
  }

  Future<void> _navigateToDetailsScreen(
      BuildContext context, Product product) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            product: product,
            onGoToCart: _onGoToCart,
          ),
        ));
  }
}
