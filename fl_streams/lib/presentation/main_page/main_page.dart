import 'package:fl_streams/business/bloc/blocs/order_bloc.dart';
import 'package:fl_streams/business/bloc/events/order_events.dart';
import 'package:fl_streams/presentation/main_page/tabs/cart/cart_tab.dart';
import 'package:fl_streams/presentation/main_page/tabs/orders/orders_tab.dart';
import 'package:fl_streams/presentation/main_page/tabs/store/store_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business/bloc/blocs/auth_bloc.dart';
import '../../business/bloc/blocs/cart_bloc.dart';
import '../../business/bloc/blocs/store_bloc.dart';
import '../../business/bloc/events/cart_events.dart';
import '../../business/bloc/events/store_events.dart';
import '../../business/bloc/states/auth_state.dart';
import '../../business/bloc/states/cart_state.dart';
import '../../common/custom_bloc/bloc_builder.dart';
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
    context.read<StoreBloc>().add(StoreFetchData());
    context.read<CartBloc>().add(CartFetchData());
    context.read<OrderBloc>().add(OrderFetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title(_currentTab)), actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => state.status == AuthStatus.loggedIn
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person),
                )
              : IconButton(
                  onPressed: _navigateToAuthPage,
                  icon: const Icon(Icons.person_off)),
        )
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          StoreTab(
              onGoToCart: () =>
                  (_bottomNavigationKey.currentWidget as BottomNavigationBar)
                      .onTap!(1)),
          CartTab(
              onAuth: _navigateToAuthPage,
              onOrder: () =>
                  (_bottomNavigationKey.currentWidget as BottomNavigationBar)
                      .onTap!(2)),
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
              icon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) => state.status == CartStatus.busy ||
                        state.status == CartStatus.loading
                    ? const CartIcon(
                        loading: true,
                      )
                    : CartIcon(superscript: state.cart.items.length),
              ),
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
    final storeBloc = context.read<StoreBloc>();
    final authBloc = context.read<AuthBloc>();
    final cartBloc = context.read<CartBloc>();
    final orderBloc = context.read<OrderBloc>();
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ));
    if (authBloc.state.status == AuthStatus.loggedIn) {
      storeBloc.add(StoreFetchData());
      cartBloc.add(CartFetchData());
      orderBloc.add(OrderFetchOrders());
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
