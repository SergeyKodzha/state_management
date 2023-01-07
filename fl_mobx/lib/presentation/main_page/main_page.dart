import 'package:fl_mobx/business/mobx/auth/auth_store.dart';
import 'package:fl_mobx/business/mobx/cart/cart_store.dart';
import 'package:fl_mobx/business/mobx/order/order_store.dart';
import 'package:fl_mobx/business/mobx/product_list/product_list_store.dart';
import 'package:fl_mobx/presentation/main_page/tabs/cart/cart_tab.dart';
import 'package:fl_mobx/presentation/main_page/tabs/orders/orders_tab.dart';
import 'package:fl_mobx/presentation/main_page/tabs/store/store_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../auth_page/auth_page.dart';
import 'widgets/cart_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _bottomNavigationKey = GlobalKey(debugLabel: 'bnb_key');
  late TabController _tabController;
  int _currentTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final productStore = context.read<ProductListStore>();
    productStore.fetchProducts();
    //
    final cartStore = context.read<CartStore>();
    cartStore.fetchCart();
    //
    final orderStore = context.read<OrderStore>();
    orderStore.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final authStore = context.read<AuthStore>();
    final cartStore = context.read<CartStore>();
    return Scaffold(
      appBar: AppBar(title: Text(_title(_currentTab)), actions: [
        Observer(
          builder: (_) => authStore.auth?.user != null
              ? const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.person),
                )
              : IconButton(
                  onPressed: _navigateToAuthPage,
                  icon: const Icon(Icons.person_off)),
        ),
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          StoreTab(
            onGoToCart: ()=> (_bottomNavigationKey.currentWidget as BottomNavigationBar).onTap!(1),
          ),
          CartTab(onAuth: _navigateToAuthPage, onOrder: () {
            (_bottomNavigationKey.currentWidget as BottomNavigationBar).onTap!(2);
          }),
          OrdersTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        currentIndex: _currentTab,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.store), label: 'Товары'),
          BottomNavigationBarItem(
              icon: Observer(
                  builder: (context) => (cartStore.state == CartState.loading ||
                          cartStore.state == CartState.updating)
                      ? const CartIcon(
                          loading: true,
                        )
                      : CartIcon(
                          superscript:
                          cartStore.cartData?.cart.items.length ?? 0,
                        )),
              label: 'Корзина'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.article), label: 'Заказы'),
        ],
        onTap: (tab) {
          setState(() {
            _currentTab = tab;
            _tabController.index = tab;
          });
        },
      ),
    );
  }

  Future<void> _navigateToAuthPage() async {
    final authStore = context.read<AuthStore>();
    final oldUser=authStore.auth?.user;
    final productStore = context.read<ProductListStore>();
    final cartStore = context.read<CartStore>();
    final orderStore=context.read<OrderStore>();
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));

    //update on auth success
    if (authStore.auth?.user!=oldUser) {
      productStore.fetchProducts();
      cartStore.fetchCart();
      orderStore.fetchOrders();
    }
  }

  String _title(int tab) {
    switch (tab) {
      case 0:
        return 'Товары';
      case 1:
        return 'Корзина';
      case 2:
        return 'Заказы';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
