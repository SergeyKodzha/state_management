import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business/bloc/blocs/auth_bloc.dart';
import '../../../../business/bloc/blocs/cart_bloc.dart';
import '../../../../business/bloc/blocs/order_bloc.dart';
import '../../../../business/bloc/events/cart_events.dart';
import '../../../../business/bloc/events/order_events.dart';
import '../../../../business/bloc/states/auth_state.dart';
import '../../../../business/bloc/states/cart_state.dart';
import '../../../../business/entities/cart_item.dart';
import '../../../../common/custom_bloc/bloc_builder.dart';
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
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      final bloc = context.read<CartBloc>();
      final cart = bloc.state.cart;
      final products = bloc.state.products;
      final enabled = bloc.state.status == CartStatus.idle;
      return state.status == CartStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : state.cart.items.isEmpty
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
                              if (newVal != 0) {
                                final newItem =
                                    CartItem(item.productId, newVal);
                                bloc.add(CartUpdateItem(newItem));
                              } else {
                                bloc.add(CartRemoveItem(item.productId));
                              }
                            },
                            onRemove: () {
                              bloc.add(CartRemoveItem(item.productId));
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
                              final auth = context.read<AuthBloc>().state;
                              if (auth.status != AuthStatus.loggedIn) {
                                _onAuth.call();
                              } else {
                                context.read<OrderBloc>().add(OrderDoOrder());
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
