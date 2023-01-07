import 'package:fl_hooks/business/application/auth_controller.dart';
import 'package:fl_hooks/business/application/cart_data_loader.dart';
import 'package:fl_hooks/business/application/order_controller.dart';
import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:fl_hooks/presentation/cart/widgets/cart_item_buy_btn.dart';
import 'package:fl_hooks/presentation/cart/widgets/cart_item_product.dart';
import 'package:fl_hooks/presentation/cart/widgets/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../business/application/cart_controller.dart';
import '../../business/entities/cart_item.dart';
import '../auth/auth_page.dart';

class CartPage extends HookWidget {
  final AuthController _authController;
  final CartController _cartController;
  CartPage(
      {Key? key,
      required AuthController authController,
      required CartController cartController})
      : _authController = authController,
        _cartController = cartController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    useListenable(_cartController.state);
    final cart = _cartController.data!;
    final productLoader = useCartDataLoader(_cartController.appService);
    final orderController = useOrderController(_cartController.appService);
    if (productLoader.data == null &&
        productLoader.state.value == HookDataState.idle) {
      productLoader.fetchCartProducts(cart);
    }
    if (orderController.data == null &&
        orderController.state.value == HookDataState.idle) {
      orderController.fetchOrder();
    }
    final products = productLoader.data;
    final order = orderController.data;
    //print('cart state: ${_cartController.state.value}');
    return order != null
        ? OrderPage(order: order, onRefresh: () async {
          await orderController.fetchOrder();
          await _cartController.fetchCart();
        },)
        : Scaffold(
            appBar: AppBar(
              title: const Text('Корзина'),
            ),
            body: products == null ||
                    productLoader.state.value == HookDataState.loading ||
                    orderController.state.value == HookDataState.loading
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
                              final product =
                                  products![cart.items[index].productId]!;
                              final item = cart.items[index];
                              return CartItemProduct(
                                  onQuantityChanged: (newVal) {
                                    final newItem =
                                        CartItem(item.productId, newVal);
                                    _cartController.setCartItem(newItem);
                                  },
                                  onRemove: () {
                                    _cartController
                                        .removeCartItem(item.productId);
                                  },
                                  product: product,
                                  item: item,
                                  enabled: _cartController.state.value !=
                                      HookDataState.updating);
                            } else {
                              num price = 0;
                              for (final item in cart.items) {
                                final totalPrice =
                                    products![item.productId]?.price ?? 0;
                                price += totalPrice * item.quantity;
                              }
                              return CartItemBuyBtn(
                                  enabled: true, //!orderController.isLoading,
                                  onBuy: () async {
                                    final user = _authController.data;
                                    if (user == null) {
                                      _navigateToAuthPage(
                                          context, _authController);
                                    } else {
                                      print('order');
                                      await orderController.order();
                                      _cartController.fetchCart();
                                    }
                                  },
                                  totalPrice: '$price руб');
                            }
                          },
                        ),
                      ),
          );
  }

  Future<dynamic> _navigateToAuthPage(
      BuildContext context, AuthController authController) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthPage(authController),
        ));
  }
}
