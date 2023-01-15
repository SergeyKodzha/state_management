import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
    required this.curForm,
    required this.curName,
    required this.curPass,
  }) : super(key: key);

  final ValueNotifier<int> curForm;
  final ValueNotifier<String> curName;
  final ValueNotifier<String> curPass;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            onPressed: (curForm.value == 0)
                ? () {
              curName.value = '';
              curPass.value = '';
              curForm.value = 1;
            }
                : null,
            child: const Text('Новый аккаунт')),
        Expanded(
          child: Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  onPressed: (curForm.value == 1)
                      ? () {
                    curName.value = '';
                    curPass.value = '';
                    curForm.value = 0;
                  }
                      : null,
                  child: const Text('Уже есть аккаунт'))),
        ),
      ],
    );
  }
}
