import 'package:fl_riverpod/presentation/cart/provider/remove_cart_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import '../auth/auth_page.dart';
import '../auth/provider/auth_provider.dart';
import 'provider/cart_products_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/order_provider.dart';
import 'provider/set_cart_item_provider.dart';
import 'widget/cart_item_buy_btn.dart';
import 'widget/cart_item_product.dart';
import 'widget/order_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(setCartItemProvider);
    ref.watch(removeCartItemProvider);
    ref.watch(cartProvider);
    ref.watch(cartProductsProvider);
    ref.watch(orderProvider);
    final cart = ref.read(cartProvider).value;
    final products = ref.read(cartProductsProvider).value;
    final isOrderLoading = ref.read(orderProvider).isLoading;
    final isOrdering = ref.read(orderProvider.notifier).isOrdering;
    final order = ref.read(orderProvider).value;
    //
    if (cart != null && !ref.read(cartProductsProvider).hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final List<ProductID> ids = [];
        for (final item in cart.items) {
          ids.add(item.productId);
        }
        ref.read(cartProductsProvider.notifier).fetchCartProducts(ids);
      });
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: (order != null)
          ? OrderPage(
              order: order,
              ref: ref,
            )
          : (cart == null || products == null || isOrderLoading || isOrdering)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cart.items.isEmpty
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
                                final newItem =
                                    CartItem(item.productId, newVal);
                                if (newVal != 0) {
                                  ref
                                      .read(setCartItemProvider.notifier)
                                      .setCartItem(newItem);
                                } else {
                                  ref
                                      .read(removeCartItemProvider.notifier)
                                      .removeCartItem(item.productId);
                                }
                              },
                              onRemove: () {
                                ref
                                    .read(removeCartItemProvider.notifier)
                                    .removeCartItem(item.productId);
                              },
                              product: products[cart.items[index].productId]!,
                              item: item,
                              enabled: !ref
                                      .read(setCartItemProvider)
                                      .isLoading &&
                                  !ref.read(removeCartItemProvider).isLoading &&
                                  !isOrdering,
                            );
                          } else {
                            num price = 0;
                            for (final item in cart.items) {
                              final totalPrice =
                                  products[item.productId]?.price ?? 0;
                              price += totalPrice * item.quantity;
                            }
                            return CartItemBuyBtn(
                                enabled: !isOrdering,
                                onBuy: () {
                                  final user = ref.read(authUserProvider);
                                  if (user == null) {
                                    _navigateToAuthPage(context, ref);
                                  } else {
                                    ref.read(orderProvider.notifier).order();
                                  }
                                },
                                totalPrice: '$price руб');
                          }
                        },
                      ),
                    ),
    );
  }

  Future<void> _navigateToAuthPage(BuildContext context, WidgetRef ref) async {
    final success = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));
    if (success) {
      ref.read(cartProvider.notifier).fetch();
    }
  }
}
