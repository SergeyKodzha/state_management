import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business/application/cart_controller.dart';
import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import '../../common/widgets/quantity_widget.dart';

class DetailsPage extends StatelessWidget {
  final CartItem item;
  final Product product;
  const DetailsPage({Key? key, required this.item, required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали')),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Padding(
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
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                      child: Consumer<CartController>(
                          builder: (context, cartModel, child) {
                            final item=cartModel.cart?.items.firstWhereOrNull((i) => i.productId==this.item.productId);
                            return Text(
                                '${(product.price * (item?.quantity??0))
                                    .toString()} руб',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20));
                          }
                      ),
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
                                Consumer<CartController>(
                                  builder: (context, cartModel, child) {
                                    final item=cartModel.cart?.items.firstWhereOrNull((i) => i.productId==this.item.productId);
                                    return QuantityWidget(
                                        enabled: !cartModel.isLoading,
                                        onChanged: (newVal) {
                                          final newItem = CartItem(
                                              this.item.productId, newVal);
                                          cartModel.setCartItem(newItem);
                                        },
                                        quantity: item?.quantity??0,
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
                                    },
                                    child: const Text('Назад')),
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
        ),
      ),
    );
  }
}


/*
class DetailsPage extends StatefulWidget {
  CartItem item;
  final Product product;
  DetailsPage({Key? key, required this.item, required this.product})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  //bool needParentUpdate=false;
  @override
  Widget build(BuildContext context) {
    ref.watch(cartProvider);
    ref.watch(setCartItemProvider);
    final cart = ref.read(cartProvider).value;
    final quantity=cart?.items.firstWhereOrNull((i) => i.productId==widget.product.id)?.quantity??0;
    print('updated $quantity');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/${widget.product.image}',
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
                          widget.product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.product.description)),
                    Divider(
                      color: Colors.black.withOpacity(0.5),
                      thickness: 2,
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                          '${(widget.product.price * quantity).toString()} руб',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
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
                                Consumer(
                                  builder: (context, ref, child) {
                                    ref.watch(setCartItemProvider);
                                    return QuantityWidget(
                                        enabled: !ref
                                            .read(setCartItemProvider)
                                            .isLoading,
                                        onChanged: (newVal) {
                                          final newItem = CartItem(
                                              widget.item.productId, newVal);
                                          ref
                                              .read(
                                                  setCartItemProvider.notifier)
                                              .setCartItem(newItem);
                                        },
                                        quantity: quantity,
                                        available: widget.product.available);
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
                                      //
                                    },
                                    child: const Text('в корзину')),
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
        ),
      ),
    );
  }
}
 */