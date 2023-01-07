import 'package:flutter/material.dart';

import '../../../business/entities/cart_item.dart';
import '../../../business/entities/product.dart';
import '../../../common/widgets/quantity_widget.dart';

class CartItemProduct extends StatelessWidget {
  final Product product;
  final CartItem item;
  final bool enabled;
  final void Function(int)? onQuantityChanged;
  final VoidCallback? onRemove;
  const CartItemProduct(
      {Key? key,
      required this.product,
      required this.item,
      this.onQuantityChanged,
      this.onRemove,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/${product.image}',
              fit: BoxFit.fitHeight,
            )),
        //SizedBox(width: 16,),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              Text('${(product.price * item.quantity).toString()} руб',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuantityWidget(
                    onChanged: onQuantityChanged,
                    quantity: item.quantity,
                    available: product.available,
                    enabled: enabled,
                  ),
                  IconButton(
                      onPressed: !enabled
                          ? null
                          : () {
                              onRemove?.call();
                            },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ]),
          ),
        ),
      ]),
    ));
  }
}
