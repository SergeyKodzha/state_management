import 'package:flutter/material.dart';

class TwoTextRow extends StatelessWidget {
  final Text leftText;
  final Text rightText;
  const TwoTextRow({Key? key, required this.leftText, required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [leftText, rightText],
    );
  }
}
