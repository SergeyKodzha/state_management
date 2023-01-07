
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business/bloc/blocs/order_bloc.dart';
import '../../../../business/bloc/events/order_events.dart';
import '../../../../business/bloc/states/order_state.dart';
import '../../../../business/entities/order.dart';
import '../../../../common/custom_bloc/bloc_builder.dart';
import 'widgets/order_item.dart';

class OrdersTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersTab> {
  final PageStorageKey scrollKey = const PageStorageKey<String>('scroll_pos');
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final busy = state.status == OrderStatus.loading ||
            state.status == OrderStatus.busy;
        final widget = busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _content(state.orders);
        if (!busy) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          }
        }
        return widget;
      },
    );
  }

  Widget _content(List<Order> orders) {
    return orders.isEmpty
        ? const Center(
            child: Text('Нет заказов'),
          )
        : Column(children: [
            Expanded(
                child: ListView.builder(
              key: scrollKey,
              controller: _scrollController,
              itemCount: orders.length,
              itemBuilder: (context, index) => OrderItem(orders[index]),
            )),
            ElevatedButton(
                onPressed: () =>
                    context.read<OrderBloc>().add(OrderFetchOrders()),
                child: const Text('Обновить'))
          ]);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
