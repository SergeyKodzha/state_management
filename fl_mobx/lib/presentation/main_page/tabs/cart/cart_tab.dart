
import 'package:fl_mobx/business/mobx/auth/auth_store.dart';
import 'package:fl_mobx/business/mobx/order/order_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';


import '../../../../business/entities/cart_item.dart';
import '../../../../business/mobx/cart/cart_store.dart';
import 'widgets/cart_item_buy_btn.dart';
import 'widgets/cart_item_product.dart';

class CartTab extends StatelessWidget {
  final VoidCallback _onAuth;
  final VoidCallback _onOrder;
  const CartTab({Key? key, required onAuth, required onOrder})
      : _onAuth = onAuth,
        _onOrder = onOrder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartStore = context.read<CartStore>();
    final orderStore = context.read<OrderStore>();
    final authStore = context.read<AuthStore>();
    return Observer(builder: (_) {
      final cartData=cartStore.cartData;
      final cart = cartData?.cart;
      final products = cartData?.products;
      final enabled = cartStore.state == CartState.idle;
      return cartStore.state == CartState.loading || cart==null || products==null
          ? const Center(child: CircularProgressIndicator())
          : cart.items.isEmpty
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
                              final newItem = CartItem(item.productId, newVal);
                              cartStore.updateCartItem(newItem);
                            },
                            onRemove: () {
                              cartStore.removeCartItem(item.productId);
                            },
                            product: product,
                            item: item,
                            enabled: enabled);
                      } else {
                        num price = 0;
                        for (final item in cart.items) {
                          final totalPrice =
                              products[item.productId]?.price ?? 0;
                          price += totalPrice * item.quantity;
                        }
                        return CartItemBuyBtn(
                            enabled: enabled,
                            onBuy: () {
                              final authed = authStore.auth?.user!=null;
                              if (!authed) {
                                _onAuth.call();
                              } else {
                                orderStore.order();
                                _onOrder();
                              }
                            },
                            totalPrice: '$price руб');
                      }
                    },
                  ),
                );
    });
  }
}
