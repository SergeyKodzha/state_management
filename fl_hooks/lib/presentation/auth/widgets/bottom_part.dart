import 'package:flutter/material.dart';

import 'buttons_row.dart';

class BottomPart extends StatelessWidget {
  final bool disabled;
  final ValueNotifier<int> curForm;
  final ValueNotifier<String> curName;
  final ValueNotifier<String> curPass;
  const BottomPart(
      {Key? key,
      required this.disabled,
      required this.curForm,
      required this.curName,
      required this.curPass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (disabled) {
      return Column(mainAxisSize: MainAxisSize.min, children: const [
        SizedBox(
          height: 32,
        ),
        CircularProgressIndicator()
      ]);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            ButtonsRow(curForm: curForm, curName: curName, curPass: curPass),
            const SizedBox(height: 32),
          ],
        ),
      );
    }
  }
}
