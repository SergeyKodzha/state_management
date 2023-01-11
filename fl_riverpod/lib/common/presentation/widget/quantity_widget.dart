import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final void Function(int)? onChanged;
  final bool enabled;
  final int available;

  const QuantityWidget(
      {Key? key,
      required this.quantity,
      this.onChanged,
      this.enabled = true,
      required this.available})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool plusEnabled = quantity < available;
    bool minusEnabled = quantity > 0;
    return SizedBox(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            minusEnabled
                ? IconButton(
                    onPressed: !enabled
                        ? null
                        : () {
                            onChanged?.call(quantity - 1);
                          },
                    icon: const Icon(Icons.remove))
                : const IconButton(onPressed: null, icon: Icon(Icons.remove)),
            Text(quantity.toString()),
            plusEnabled
                ? IconButton(
                    onPressed: !enabled
                        ? null
                        : () {
                            onChanged?.call(quantity + 1);
                          },
                    icon: const Icon(Icons.add))
                : const IconButton(onPressed: null, icon: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
