import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../business/bloc/blocs/store_bloc.dart';
import '../../../../business/bloc/events/store_events.dart';
import '../../../../business/bloc/states/store_state.dart';
import '../../../../business/entities/product.dart';
import '../../../../common/custom_bloc/bloc_builder.dart';
import '../../../details_page/details_page.dart';
import 'widgets/store_item.dart';

class StoreTab extends StatelessWidget {
  final VoidCallback _onGoToCart;
  const StoreTab({super.key, required onGoToCart}) : _onGoToCart = onGoToCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        final products = state.products;
        return state.status == StoreStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _productList(products);
      },
    );
  }

  void _reload(BuildContext context) {
    final bloc = context.read<StoreBloc>();
    bloc.add(StoreFetchData());
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
