import 'package:collection/collection.dart';
import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../business/application/cart_model.dart';
import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import '../../common/widgets/quantity_widget.dart';

class DetailsPage extends HookWidget {
  final CartItem item;
  final Product product;
  final CartModel _cartController;
  const DetailsPage(
      {required CartModel cartController,
      required this.item,
      required this.product,
      Key? key})
      : _cartController = cartController,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    useListenable(_cartController.state);
    final cart = _cartController.data!;
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
                      child: LayoutBuilder(builder: (_, __) {
                        final item = cart.items.firstWhereOrNull(
                            (i) => i.productId == this.item.productId);
                        return Text(
                            '${(product.price * (item?.quantity ?? 0)).toString()} руб',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20));
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
                                    final item = cart.items.firstWhereOrNull(
                                        (i) =>
                                            i.productId == this.item.productId);
                                    final enabled =
                                        _cartController.state.value ==
                                            HookDataState.loaded;
                                    return QuantityWidget(
                                        enabled: enabled,
                                        onChanged: (newVal) {
                                          final newItem = CartItem(
                                              this.item.productId, newVal);
                                          _cartController.setCartItem(newItem);
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
