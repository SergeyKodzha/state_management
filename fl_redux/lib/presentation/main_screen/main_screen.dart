import 'package:fl_redux/common/widgets/loading_tab.dart';
import 'package:fl_redux/presentation/main_screen/tabs/orders/orders_tab.dart';
import 'package:fl_redux/presentation/main_screen/tabs/store/view_models/store_tab_vm.dart';
import 'package:fl_redux/presentation/main_screen/widgets/cart_icon.dart';
import 'package:fl_redux/presentation/main_screen/tabs/store/store_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../business/redux/actions/cart_actions.dart';
import '../../business/redux/actions/order_actions.dart';
import '../../business/redux/actions/store_actions.dart';
import '../../business/redux/states/app_state.dart';
import '../../business/redux/states/auth.dart';
import '../../business/redux/states/cart.dart';
import '../../business/redux/states/orders.dart';
import '../../business/redux/states/store.dart';
import '../auth_screen/auth_screen.dart';
import 'tabs/cart/cart_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey bottomNavigationKey=GlobalKey(debugLabel: 'bnb_key');
  late TabController _tabController;
  int _currentTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      final store = StoreProvider.of<AppState>(context, listen: false);
      store.dispatch(StoreLoadAction());
      store.dispatch(FetchCartDataAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title(_currentTab)), actions: [
        StoreConnector<AppState, AuthState>(
          distinct: true,
          converter: (store) => store.state.authData.state,
          builder: (context, authState) => authState != AuthState.authed
              ? IconButton(
                  onPressed: _navigateToAuthScreen,
                  icon: const Icon(Icons.person_off))
              : const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person),
                ),
        ),
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          StoreConnector<AppState, StoreTabViewModel>(
              distinct: true,
              converter: (store) => StoreTabViewModel(
                  store.state.storeData.state, store.state.storeData.products),
              builder: (context, vm) {
                return vm.state == StoreState.loading
                    ? const LoadingTab()
                    : StoreTab(onGoToCart: () => (bottomNavigationKey.currentWidget as BottomNavigationBar).onTap!(1),);
              }),
          //const Center(child: Text('tab 1')),
          StoreConnector<AppState, CartState>(
            distinct: true,
            converter: (store) {
              return store.state.cartData.state;
            },
            builder: (context, cartState) {
              return cartState == CartState.loading
                  ? const LoadingTab()
                  : CartTab(onAuth: () => _navigateToAuthScreen(),onOrder: () => (bottomNavigationKey.currentWidget as BottomNavigationBar).onTap!(2),);
            },
          ),
         OrdersTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: bottomNavigationKey,
        currentIndex: _currentTab,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.store), label: 'Товары'),
          BottomNavigationBarItem(
              icon: StoreConnector<AppState, int>(
                distinct: true,
                converter: (store) {
                  //return CartButtonViewModel(store.state.cartData.cart.items.length);
                  return store.state.cartData.cart.items.length;
                },
                builder: (context, numItems) => CartIcon(superscript: numItems),
              ),
              label: 'Корзина'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.article), label: 'Заказы'),
        ],
        onTap: (tab) {
          setState(() {
            if (tab == 1 && _tabController.index != 1) {
              StoreProvider.of<AppState>(context, listen: false)
                  .dispatch(FetchCartDataAction());
            }
            if (tab == 2 && _tabController.index != 2) {
              StoreProvider.of<AppState>(context, listen: false)
                  .dispatch(FetchOrdersAction());
            }
            _currentTab = tab;
            _tabController.index = tab;
          });
        },
      ),
    );
  }

  Future<void> _navigateToAuthScreen() async {
    final store = StoreProvider.of<AppState>(context, listen: false);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ));

    if (store.state.authData.state == AuthState.authed) {
      store.dispatch(FetchCartDataAction());
      if (_currentTab==2){
        if (store.state.ordersData.state!=OrdersState.ordering) {
          store.dispatch(FetchOrdersAction());
        }
      }
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
