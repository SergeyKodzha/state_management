
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/widgets/cart_item_buy_btn.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/widgets/cart_item_product.dart';
import 'package:flutter/material.dart';

import '../../../../../business/entities/cart_item.dart';

Widget buildView(CartState state, Dispatch dispatch, ViewService viewService) {
  if (state.status==CartStatus.loading || state.status==CartStatus.updating){
    return const Center(child: CircularProgressIndicator(),);
  } else {
    final cart=state.cart;
    final products=state.products;
    final enabled=state.status==CartStatus.loaded;
    return state.cart.items.isEmpty
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
                  dispatch(CartActions.setItem(newItem));
                },
                onRemove: () {
                  if (product!=null) {
                    dispatch(CartActions.removeItem(product.id));
                  }
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
                  dispatch(MainPageActions.order());
                  /*
                  final auth = context.read<AuthBloc>().state;
                  if (auth.status != AuthStatus.loggedIn) {
                    _onAuth.call();
                  } else {
                    context.read<OrderBloc>().add(OrderDoOrder());
                    _onOrder();
                  }
                   */
                },
                totalPrice: '$price руб');
          }
        },
      ),
    );

  }
}