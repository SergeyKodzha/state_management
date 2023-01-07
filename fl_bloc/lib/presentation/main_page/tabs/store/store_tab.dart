import 'package:fl_bloc/business/bloc/blocs/store_bloc.dart';
import 'package:fl_bloc/business/bloc/events/store_events.dart';
import 'package:fl_bloc/business/bloc/states/store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../business/entities/product.dart';
import '../../../details_page/details_screen.dart';
import 'widgets/store_item.dart';

class StoreTab extends StatelessWidget {
  final VoidCallback _onGoToCart;
  const StoreTab({super.key, required onGoToCart}):_onGoToCart=onGoToCart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state.status == StoreStatus.needData) {
          _reload(context);
        }
        final products = state.products;
        return state.status == StoreStatus.loading ||
                state.status == StoreStatus.needData
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
