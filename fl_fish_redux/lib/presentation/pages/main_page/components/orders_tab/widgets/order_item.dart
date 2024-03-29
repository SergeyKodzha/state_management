import 'package:fl_fish_redux/business/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Заказ #${order.id}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    _date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            Row(
              children: [
               Padding(
                 padding: const EdgeInsets.only(left: 8.0),
                 child: _icon(),
               ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Цена: ${order.cost} руб',),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Статус: $_status'),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            )
          ],
        )));
  }
  Widget _icon(){
    final delivered=_delivered;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: delivered?Colors.green:Colors.yellow,
      ),
      child: Icon(delivered?Icons.done:Icons.delivery_dining,size: 40),
    );
  }
  String get _date{
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(order.created);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
  String get _status{
    final timeLast=order.deliveryIn-(DateTime.now().millisecondsSinceEpoch-order.created);
    if (timeLast<=0){
      return 'Доставлено';
    } else {
      if (timeLast>60*1000){
        return 'Доставка через ${timeLast.toDouble()/1000~/60} минут';
      } else {
        return 'Доставка через ${timeLast.toDouble()/1000} секунд';
      }
    }
  }
  bool get _delivered{
    return DateTime.now().millisecondsSinceEpoch>=order.created+order.deliveryIn;
  }
}
