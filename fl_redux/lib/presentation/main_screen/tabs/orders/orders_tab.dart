import 'package:fl_redux/presentation/main_screen/tabs/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../business/entities/order.dart';
import '../../../../business/redux/actions/order_actions.dart';
import '../../../../business/redux/states/app_state.dart';
import '../../../../business/redux/states/orders.dart';
import '../../../../common/widgets/loading_tab.dart';

class OrdersTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersTab> {
  final PageStorageKey scrollKey = const PageStorageKey<String>('scroll_pos');
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OrdersTabData>(
      distinct: true,
      converter: (store) {
        return store.state.ordersData;
      },
      builder: (context, ordersData) {
        final widget = ordersData.state == OrdersState.loading ||
                ordersData.state == OrdersState.ordering
            ? const LoadingTab()
            : _content(ordersData.orders);
        if (widget is! LoadingTab) {
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
                    StoreProvider.of<AppState>(context, listen: false)
                        .dispatch(FetchOrdersAction()),
                child: const Text('Обновить'))
          ]);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
