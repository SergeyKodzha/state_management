import 'package:collection/collection.dart';
import 'package:fl_mobx/business/mobx/cart/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import '../../common/widgets/quantity_widget.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  final VoidCallback onGoToCart;
  const DetailsPage({Key? key, required this.product, required this.onGoToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartStore = context.read<CartStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
      ),
      body: Observer(
        builder: (_) {
          final item = cartStore.cartData?.cart.items.firstWhereOrNull(
            (item) => item.productId == product.id,
          );
          return cartStore.state == CartState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/${product.image}',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
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
                                    '${(product.price * (item?.quantity ?? 0)).toString()} руб',
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
                              //mainAxisSize: MainAxisSize.min,
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
                                            final enabled = cartStore.state ==
                                                CartState.idle;
                                            return QuantityWidget(
                                                enabled: enabled,
                                                onChanged: (newVal) {
                                                  final newItem = CartItem(
                                                      product.id, newVal);
                                                  cartStore
                                                      .updateCartItem(newItem);
                                                  //StoreProvider.of<AppState>(context).dispatch(UpdateCartItemAction(newItem));
                                                },
                                                quantity: item?.quantity ?? 0,
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
                      ),
                    ),
                  ]),
                );
        },
      ),
    );
  }
}
