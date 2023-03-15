import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart_item.dart';
import 'package:fl_fish_redux/presentation/pages/details_page/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';
import 'package:flutter/material.dart';

import '../../../business/entities/product.dart';
import '../../../common/widgets/quantity_widget.dart';
import '../main_page/components/cart_tab/actions.dart';
import 'actions.dart';

Widget buildPage(
    DetailsState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final product = state.product;
    final item = state.cartItem;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Детали'),
        ),
        body: Padding(
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
                        return Text(
                            '${(product.price * (item.quantity ?? 0)).toString()} руб',
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
                                    final enabled = state.status==DetailsStatus.enabled;
                                    return QuantityWidget(
                                        enabled: enabled,
                                        onChanged: (newVal) {
                                          final newItem =
                                              CartItem(product.id, newVal);
                                          viewService.broadcast(CartActions.setItem(newItem));
                                        },
                                        quantity: item.quantity,
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
                                      dispatch(DetailsActions.goToCart());
                                    },
                                    child: const Text('Перейти к оформлению')),
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
        ));
  });
}
