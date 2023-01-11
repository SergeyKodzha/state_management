import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_state/business/entities/cart.dart';

import '../../business/application/auth_model.dart';
import '../../business/application/cart_model.dart';
import '../../business/application/order_model.dart';
import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import '../auth/auth_page.dart';
import 'widgets/cart_item_buy_btn.dart';
import 'widgets/cart_item_product.dart';
import 'widgets/order_page.dart';

class CartPage extends StatelessWidget {
  final Map<ProductID, Product> products;
  const CartPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<OrderModel>();
    context.watch<CartModel>();
    final cartModel = context.read<CartModel>();
    final orderModel = context.read<OrderModel>();
    final order = orderModel.order;
    final cart = cartModel.cart??Cart([]);
    if (order != null) {
      return OrderPage(order: order);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Корзина'),
        ),
        body: cart.items.isEmpty
            ? const Center(
                child: Text('Ничего нет :('),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: cart.items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < cart.items.length) {
                      final item = cart.items[index];
                      return CartItemProduct(
                          onQuantityChanged: (newVal) {
                            final newItem = CartItem(item.productId, newVal);
                            if (newVal != 0) {
                              cartModel.setCartItem(newItem);
                            } else {
                              cartModel.removeCartItem(item.productId);
                            }
                          },
                          onRemove: () {
                            cartModel.removeCartItem(item.productId);
                          },
                          product: products[cart.items[index].productId]!,
                          item: item,
                          enabled: !cartModel.isLoading &&
                              !orderModel.isLoading);
                    } else {
                      num price = 0;
                      for (final item in cart.items) {
                        final totalPrice = products[item.productId]?.price ?? 0;
                        price += totalPrice * item.quantity;
                      }
                      return CartItemBuyBtn(
                          enabled: !orderModel.isLoading,
                          onBuy: () async {
                            final user = context.read<AuthModel>().user;
                            if (user == null) {
                              _navigateToAuthPage(context);
                            } else {
                              await orderModel.doOrder();
                              await cartModel.fetchCart();
                            }
                          },
                          totalPrice: '$price руб');
                    }
                  },
                ),
              ),
      );
    }
  }

  void _navigateToAuthPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));
  }
}
