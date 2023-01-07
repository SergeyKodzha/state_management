import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/cart_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/widgets/cart_icon.dart';
import 'package:flutter/material.dart';

Widget buildPage(MainState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final GlobalKey bottomNavigationKey = GlobalKey(debugLabel: 'bnb_key');
    return Scaffold(
      appBar: AppBar(title: Text(_title(state.currentTab)), actions: [
        Builder(
          builder: (_) {
            return state.user != null
                ? const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.person),
            )
                : IconButton(
                onPressed: () => dispatch(MainPageActions.login()),
                icon: const Icon(Icons.person_off));
          },
        ),
      ]),
      body: TabBarView(
        viewportFraction: 0.999,//говнокод чтобы корзина была на экране, потому что иначе она не слышит экшены,обращенные к ней.
        physics: const NeverScrollableScrollPhysics(),
        controller: state.tabController,
        children: [
          viewService.buildComponent('store'),
          viewService.buildComponent('cart'),
          viewService.buildComponent('orders'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: bottomNavigationKey,
        currentIndex: state.currentTab,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.store), label: 'Товары'),
          BottomNavigationBarItem(
              icon: Builder(builder: (_) {
                final status = state.cartState.status;
                return status == CartStatus.initial ||
                    status == CartStatus.loading ||
                    status == CartStatus.updating
                    ? const CartIcon(
                  loading: true,
                )
                    : CartIcon(
                  superscript: state.cartState.cart.items.length,
                );
              }),
              label: 'Корзина'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.article), label: 'Заказы'),
        ],
        onTap: (tab) {
          if (tab!=state.currentTab) {
            dispatch(MainPageActions.showTab(tab));
          }
        },
      ),
    );
  },);
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