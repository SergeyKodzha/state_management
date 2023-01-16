
import 'package:fl_bloc/business/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/bloc/blocs/cart_bloc.dart';
import '../../../business/bloc/events/cart_events.dart';
import '../../../business/entities/cart_item.dart';
import '../../../common/widgets/quantity_widget.dart';

class DetailsInfoCard extends StatelessWidget {
  final bool enabled;
  final Product product;
  final CartItem cartItem;
  final VoidCallback onGoToCart;
  const DetailsInfoCard({Key? key,required this.product, required this.cartItem, this.enabled=true, required this.onGoToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                product.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          const SizedBox(
            height: 8,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(product.description)),
          Divider(
            color: Colors.black.withOpacity(0.5),
            thickness: 2,
            height: 16,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: LayoutBuilder(builder: (_, __) {
              return Text(
                  '${(product.price * (cartItem.quantity)).toString()} руб',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20));
            }),
          ),
          Divider(
            color: Colors.black.withOpacity(0.5),
            thickness: 2,
            height: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'количество:',
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LayoutBuilder(
                        builder: (_, __) {
                          return QuantityWidget(
                              enabled: enabled,
                              onChanged: (newVal) {
                                final newItem = CartItem(
                                    product.id, newVal);
                                context.read<CartBloc>().add(
                                    CartUpdateItem(newItem));
                              },
                              quantity: cartItem.quantity,
                              available: product.available);
                        },
                      ),
                    ]),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.5),
            thickness: 2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onGoToCart.call();
                          },
                          child: const Text(
                              'Перейти к оформлению')),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
