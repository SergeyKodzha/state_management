import 'package:flutter/material.dart';

class OrderIcon extends StatelessWidget {
  const OrderIcon({
    Key? key,
    required bool delivered,
  })  : _delivered = delivered,
        super(key: key);

  final bool _delivered;

  @override
  Widget build(BuildContext context) {
    final delivered = _delivered;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: delivered ? Colors.green : Colors.yellow,
      ),
      child: Icon(delivered ? Icons.done : Icons.delivery_dining, size: 40),
    );
  }
}
