import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../../business/entities/order.dart';
import '../../../../business/mobx/order/order_store.dart';
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
    final orderStore=context.read<OrderStore>();
    return Observer(
      builder: (_) {
        print('order update');
        final loading = orderStore.state == OrderState.loading ||
            orderStore.state == OrderState.ordering;
        final widget = loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _content(orderStore.orders,orderStore);
        if (!loading) {
          WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            }
          });
        }
        return widget;
      },
    );
  }

  Widget _content(List<Order> orders,OrderStore store) {
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
                onPressed: store.fetchOrders,
                child: const Text('Обновить'))
          ]);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
