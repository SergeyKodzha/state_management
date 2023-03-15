import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/orders_tab/widgets/order_item.dart';
import 'package:flutter/material.dart';

import 'actions.dart';

Widget buildView(
    OrdersState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final loading = state.status == OrdersStatus.loading ||
        state.status == OrdersStatus.ordering;
    final widget = loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _content(state, dispatch);
    if (!loading) {
      if (state.scrollController.hasClients==true) {
        state.scrollController.animateTo(
          state.scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      }
    }
    return widget;
  });
}

Widget _content(OrdersState state, Dispatch dispatch) {
  return state.orders.isEmpty
      ? const Center(
          child: Text('Нет заказов'),
        )
      : Column(children: [
          Expanded(
              child: ListView.builder(
            key: state.scrollKey,
            controller: state.scrollController,
            itemCount: state.orders.length,
            itemBuilder: (context, index) => OrderItem(state.orders[index]),
          )),
          ElevatedButton(
              onPressed: () => dispatch(OrderActions.load()),
              child: const Text('Обновить'))
        ]);
}
