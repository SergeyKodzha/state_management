import 'package:fl_hooks/business/application/app_service.dart';
import 'package:fl_hooks/business/application/auth_controller.dart';
import 'package:fl_hooks/business/application/cart_controller.dart';
import 'package:fl_hooks/business/application/store_controller.dart';
import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:fl_hooks/presentation/auth/auth_page.dart';
import 'package:fl_hooks/presentation/cart/cart_page.dart';
import 'package:fl_hooks/presentation/details/details_page.dart';
import 'package:fl_hooks/presentation/store/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import 'widgets/store_item.dart';

class StorePage extends HookWidget {
  final AppService _appService;
  const StorePage(this._appService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = useAuthController(_appService);
    final storeController = useStoreController(_appService);
    final cartController = useCartController(_appService);
    final cart = cartController.data;
    final products = storeController.data ?? [];
    if (storeController.data == null &&
        storeController.state.value == HookDataState.idle) {
      storeController.fetchAllProducts();
    }
    if (cartController.data == null &&
        cartController.state.value == HookDataState.idle) {
      cartController.fetchCart();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Товары'), actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cartController.state.value == HookDataState.loading ||
                    cartController.state.value == HookDataState.updating
                ? const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : CartButton(
                    superscript: cart != null
                        ? (cart.items.isEmpty)
                            ? null
                            : cart.items.length.toString()
                        : null,
                    onPressed: () {
                      _navigateToCartPage(context, cartController, authController);
                    }),
          ],
        ),
        authController.data == null
            ? IconButton(
                onPressed: () async {
                  await _navigateToAuthPage(context, authController);
                  if (authController.data != null) {
                    cartController.fetchCart();
                  }
                },
                icon: const Icon(Icons.person_off))
            : const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.person),
              ),
      ]),
      body: (storeController.state.value == HookDataState.loading ||
              cartController.state.value == HookDataState.loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 40 / 56,
              ),
              itemBuilder: (context, index) {
                return StoreItem(
                  product: products[index],
                  onTap: (product) {
                    final ready =
                        cartController.state.value == HookDataState.loaded;
                    if (ready) {
                      final cart = cartController.data!;
                      CartItem item = CartItem(product.id, 0);
                      for (final i in cart.items) {
                        if (i.productId == product.id) {
                          item = i;
                          break;
                        }
                      }
                      _navigateToDetailsPage(
                          context, cartController, product, item);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: SizedBox(
                                height: 20,
                                child: Center(child: Text('Cart not loaded')))),
                      );
                    }
                  },
                );
              }),
    );
  }

  Future<dynamic> _navigateToAuthPage(
      BuildContext context, AuthController authController) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthPage( authController),
        ));
  }

  Future<dynamic> _navigateToDetailsPage(BuildContext context,
      CartController cartController, Product product, CartItem item) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsPage(
                cartController: cartController, item: item, product: product)));
  }

  Future<dynamic> _navigateToCartPage(BuildContext context,
      CartController cartController,AuthController authController) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartPage(authController: authController, cartController: cartController)));
  }
}
