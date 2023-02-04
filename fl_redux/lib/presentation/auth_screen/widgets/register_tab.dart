import 'package:flutter/material.dart';

import '../../../common/widgets/loading_tab.dart';

class RegisterTab extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final ValueNotifier<bool> btnEnabled = ValueNotifier(false);
  final void Function(String, String)? onRegister;
  RegisterTab(
      {Key? key, String? prefilledName, String? prefilledPass, this.onRegister})
      : super(key: key) {
    _nameController.text = prefilledName ?? '';
    _passController.text = prefilledPass ?? '';
    _passConfirmController.text = prefilledPass ?? '';
    btnEnabled.value = _isBtnEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Регистрация',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      onChanged: (value) => btnEnabled.value = _isBtnEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Имя",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passController,
                      onChanged: (value) => btnEnabled.value = _isBtnEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Пароль",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passConfirmController,
                      onChanged: (value) => btnEnabled.value = _isBtnEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Повторите пароль",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ValueListenableBuilder<bool>(
                        valueListenable: btnEnabled,
                        builder: (context, enabled, child) => ElevatedButton(
                              onPressed: !enabled
                                  ? null
                                  : () => onRegister?.call(_nameController.text,
                                      _passController.text),
                              child: const Text("Зарегестрироваться"),
                            )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  bool _isBtnEnabled() {
    final text1 = _nameController.text;
    final text2 = _passController.text;
    final text3 = _passConfirmController.text;
    if (text1.isEmpty || text2.isEmpty || text3.isEmpty || text2 != text3) {
      return false;
    }
    return true;
  }
}
