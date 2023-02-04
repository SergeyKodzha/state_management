import 'package:flutter/material.dart';

class CartItemBuyBtn extends StatelessWidget {
  final VoidCallback? onBuy;
  final String totalPrice;
  final bool enabled;
  const CartItemBuyBtn(
      {this.onBuy, this.totalPrice = '', Key? key, this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'Итого: $totalPrice',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: enabled ? onBuy : null,
                    child: const Text('купить'))),
          ],
        ),
      ],
    );
  }
}
