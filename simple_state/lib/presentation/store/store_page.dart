import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business/application/auth_controller.dart';
import '../../business/application/cart_controller.dart';
import '../../business/application/cart_products_loader.dart';
import '../../business/application/store_controller.dart';
import '../../business/entities/cart_item.dart';
import '../../business/entities/product.dart';
import '../auth/auth_page.dart';
import '../cart/cart_page.dart';
import '../details/details_page.dart';
import 'widgets/cart_button.dart';
import 'widgets/store_item.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.watch<StoreController>();
    //final productLoader=context.read<CartProductsLoader>();
    final products = storeModel.products;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Продукты'),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CartController>(
                  builder: (_, cartModel, __) {
                    final count = cartModel.cart?.items.length ?? 0;
                    return cartModel.isLoading
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          )
                        : CartButton(
                            superscript: count > 0 ? count.toString() : null,
                            onPressed: () {
                              final cart = context.read<CartController>().cart;
                              if (cart != null) {
                                final List<ProductID> ids = [];
                                for (final item in cart.items) {
                                  ids.add(item.productId);
                                }
                                final productLoader =
                                    context.read<CartProductsLoader>();
                                productLoader.fetchProducts(ids);
                              }
                            },
                          );
                  },
                ),
              ],
            ),
            Consumer<AuthController>(
              builder: (_, authModel, __) {
                return authModel.user == null
                    ? IconButton(
                        onPressed: () => _navigateToAuthPage(context),
                        icon: const Icon(Icons.person_off))
                    : const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.person),
                      );
              },
            ),
          ],
        ),
        body: storeModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : IgnorePointer(
                ignoring: context.read<CartProductsLoader>().isLoading,
                child: Stack(
                  children: [
                    GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 40 / 57,
                        ),
                        itemBuilder: (context, index) {
                          return StoreItem(
                            product: products[index],
                            onTap: (product) {
                              final cart = context.read<CartController>().cart;
                              if (cart != null) {
                                CartItem item = CartItem(product.id, 0);
                                for (final i in cart.items) {
                                  if (i.productId == product.id) {
                                    item = i;
                                    break;
                                  }
                                }
                                _navigateToDetailsPage(context, product, item);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: SizedBox(
                                          height: 20,
                                          child: Center(
                                              child:
                                                  Text('Cart is not loaded')))),
                                );
                              }
                            },
                          );
                        }),

                    //cart products loader
                    Consumer<CartProductsLoader>(
                      builder: (context, loader, child) {
                        if (loader.isLoading) {
                          return Center(child: _preloaderBox());
                        } else {
                          if (loader.hasData) {
                            WidgetsBinding.instance
                                .scheduleFrameCallback((timeStamp) {
                              _navigateToCartPage(context,loader.products);
                              loader.consumeData();
                            });
                          }
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ));
  }

  Widget _preloaderBox() {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: Container(
          //width: 64,
          //height: 64,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2))
              ],
              borderRadius: BorderRadius.circular(8)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )),
    );
  }

  void _navigateToAuthPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));
  }

  void _navigateToDetailsPage(
      BuildContext context, Product product, CartItem item) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(item: item, product: product),
        ));
  }

  void _navigateToCartPage(BuildContext context,Map<ProductID,Product> products) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(products: products),
        ));
  }
}
