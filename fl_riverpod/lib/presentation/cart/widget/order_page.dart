import 'package:fl_riverpod/presentation/cart/widget/two_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/order.dart';
import '../provider/order_provider.dart';

class OrderPage extends StatelessWidget {
  final Order order;
  final WidgetRef ref;

  const OrderPage({required this.order, Key? key, required this.ref})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          TwoTextRow(
              leftText: const Text('Создан: '),
              rightText: Text(DateTime.fromMillisecondsSinceEpoch(order.created)
                  .toString())),
          const SizedBox(
            height: 8,
          ),
          TwoTextRow(
            leftText: const Text('Доставка через: '),
            rightText: Text(
                '${(order.deliveryIn - (DateTime.now().millisecondsSinceEpoch - order.created)) / 1000 / 60} минут'),
          ),
          const SizedBox(
            height: 8,
          ),
          TwoTextRow(
            leftText: const Text('Цена заказа: '),
            rightText: Text('${order.cost} руб'),
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
                          onPressed: () => ref.invalidate(orderProvider),
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
    );
  }
}
