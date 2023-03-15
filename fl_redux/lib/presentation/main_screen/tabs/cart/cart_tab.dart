
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


import '../../../../business/entities/cart_item.dart';
import '../../../../business/redux/actions/cart_actions.dart';
import '../../../../business/redux/actions/order_actions.dart';
import '../../../../business/redux/states/app_state.dart';
import '../../../../business/redux/states/auth.dart';
import '../../../../business/redux/states/cart.dart';
import 'widgets/cart_item_buy_btn.dart';
import 'widgets/cart_item_product.dart';

class CartTab extends StatelessWidget {
  final VoidCallback onAuth;
  final VoidCallback onOrder;
  const CartTab({Key? key, required this.onAuth, required this.onOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context,listen: false);
    final cart = store.state.cartData.cart;
    final products = store.state.cartData.products;
    final enabled = store.state.cartData.state == CartState.idle;
    return cart.items.isEmpty
        ? const Center(
            child: Text('Ничего нет'),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: cart.items.length + 1,
              itemBuilder: (context, index) {
                if (index < cart.items.length) {
                  final product = products[cart.items[index].productId];
                  final item = cart.items[index];
                  return CartItemProduct(
                      onQuantityChanged: (newVal) {
                        if (newVal>0) {
                          final newItem = CartItem(item.productId, newVal);
                          store.dispatch(UpdateCartItemAction(newItem));
                        } else {
                          store.dispatch(DeleteCartItemAction(item.productId));
                        }
                      },
                      onRemove: () {
                        store.dispatch(DeleteCartItemAction(item.productId));
                      },
                      product: product,
                      item: item,
                      enabled: enabled);
                } else {
                  num price = 0;
                  for (final item in cart.items) {
                    final totalPrice = products[item.productId]?.price ?? 0;
                    price += totalPrice * item.quantity;
                  }
                  return CartItemBuyBtn(
                      enabled: enabled,
                      onBuy: () {
                        final store=StoreProvider.of<AppState>(context,listen: false);
                        final auth=store.state.authData;
                        if (auth.state!=AuthState.authed){
                          onAuth.call();
                        } else {
                          store.dispatch(DoOrderAction());
                          onOrder.call();
                        }
                      },
                      totalPrice: '$price руб');
                }
              },
            ),
          );
  }
}
