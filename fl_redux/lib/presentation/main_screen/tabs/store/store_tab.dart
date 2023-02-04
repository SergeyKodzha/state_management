import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../business/entities/product.dart';
import '../../../../business/redux/states/app_state.dart';
import '../../../details_screen/details_screen.dart';
import 'widgets/store_item.dart';

class StoreTab extends StatelessWidget {
  final VoidCallback onGoToCart;
  const StoreTab({Key? key, required this.onGoToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Product>>(
      distinct: true,
      converter: (store) => store.state.storeData.products,
      builder: (context, products) => GridView.builder(
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
          }),
    );
  }

  Future<void> _navigateToDetailsScreen(
      BuildContext context, Product product) async {
    final store = StoreProvider.of<AppState>(context, listen: false);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            product: product,
            onGoToCart: onGoToCart,
          ),
        ));
  }
}
