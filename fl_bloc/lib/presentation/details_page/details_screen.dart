import 'package:collection/collection.dart';
import 'package:fl_bloc/business/bloc/blocs/cart_bloc.dart';
import 'package:fl_bloc/business/bloc/states/cart_state.dart';
import 'package:fl_bloc/presentation/details_page/widgets/details_image_card.dart';
import 'package:fl_bloc/presentation/details_page/widgets/details_info_card.dart';
import 'package:fl_bloc/presentation/details_page/widgets/details_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  final VoidCallback onGoToCart;
  const DetailsPage({Key? key, required this.product, required this.onGoToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final item = state.cart.items.firstWhereOrNull(
            (item) => item.productId == product.id,
          )?? CartItem(product.id,0);
          return state.status == CartStatus.loading
              ? const DetailsLoading()
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Expanded(
                      flex: 1,
                      child: DetailsImageCard(image:product.image),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailsInfoCard(
                        product: product,
                        cartItem: item,
                        enabled: state.status==CartStatus.idle,
                        onGoToCart: onGoToCart,)
                    ),
                  ]),
                );
        },
      ),
    );
  }
}
