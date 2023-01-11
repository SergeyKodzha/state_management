import 'package:fl_riverpod/presentation/store/widget/store_list.dart';
import 'package:fl_riverpod/presentation/store/widget/store_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/presentation/widget/cart_button.dart';
import '../../common/presentation/widget/cart_button_loading.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import '../auth/auth_page.dart';
import '../auth/provider/auth_provider.dart';
import '../cart/cart_page.dart';
import '../cart/provider/cart_provider.dart';
import '../details/details_page.dart';
import 'provider/store_provider.dart';

class StorePage extends ConsumerStatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StoreState();
}

class StoreState extends ConsumerState<StorePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);
    final listingState = ref.watch(storeListingProvider);
    final products = listingState.value ?? [];
    final isCartLoading = ref.watch(cartProvider).isLoading;
    final cart = ref.watch(cartProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Товары'),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isCartLoading
                  ? const CartButtonLoading()
                  : CartButton(
                      superscript: isCartLoading
                          ? null
                          : (cart == null || cart.items.isEmpty)
                              ? null
                              : cart.items.length.toString(),
                      onPressed: () => _navigateToCartPage(),
                    ),
            ],
          ),
          user == null
              ? IconButton(
                  onPressed: () {
                    _navigateToAuthPage();
                  },
                  icon: const Icon(Icons.person))
              : const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person),
                ),
        ],
      ),
      body: listingState.isLoading == true || cart == null
          ? const StoreLoading()
          : StoreList(
              products: listingState.value ?? [],
              onTap: (product) {
                CartItem item = CartItem(product.id, 0);
                for (final i in cart.items) {
                  if (i.productId == product.id) {
                    item = i;
                    break;
                  }
                }
                _navigateToDetailsPage(product, item);
              },
            ),
    );
  }

  Future<void> _navigateToDetailsPage(Product product, CartItem item) async {
    final res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(item: item, product: product),
        ));
  }

  Future<void> _navigateToAuthPage() async {
    final success = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));
    if (success) {
      ref.read(cartProvider.notifier).fetch();
    }
  }

  Future<void> _navigateToCartPage() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ));
  }
}
