import 'package:flutter/material.dart';
import '../../../business/entities/order.dart';

class OrderPage extends StatelessWidget {
  final Order order;
  final VoidCallback? onRefresh;
  const OrderPage({required this.order, required this.onRefresh, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Текущий заказ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Ваш заказ в пути!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Айди заказа: '),
                Text(order.id),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Создан: '),
                Text(DateTime.fromMillisecondsSinceEpoch(order.created)
                    .toString()),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Доставка через: '),
                Text(
                    '${(order.deliveryIn - (DateTime.now().millisecondsSinceEpoch - order.created)) / 1000 / 60} минут'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Цена заказа: '),
                Text('${order.cost} руб'),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: (DateTime.now().millisecondsSinceEpoch -
                                order.created) /
                            order.deliveryIn,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              onRefresh?.call();
                            },
                            child: const Text('Обновить'),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
