import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final bool enabled;
  final ValueNotifier<bool> btnEnabled = ValueNotifier(false);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final void Function(String, String) onRegister;

  RegisterForm(
      {Key? key,
      this.enabled = true,
      required this.onRegister,
      String? name,
      String? pass})
      : super(key: key) {
    _nameController.text = name ?? '';
    _passController.text = pass ?? '';
    _passConfirmController.text = pass ?? '';
    btnEnabled.value = _isEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      enabled: enabled,
                      onChanged: (value) => btnEnabled.value = _isEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Имя",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passController,
                      enabled: enabled,
                      onChanged: (value) => btnEnabled.value = _isEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Пароль",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passConfirmController,
                      enabled: enabled,
                      onChanged: (value) => btnEnabled.value = _isEnabled(),
                      decoration: const InputDecoration(
                        hintText: "Повторите пароль",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ValueListenableBuilder<bool>(
                        valueListenable: btnEnabled,
                        builder: (context, enabled, child) => ElevatedButton(
                              onPressed: (enabled && this.enabled)
                                  ? () {
                                      onRegister(_nameController.text,
                                          _passController.text);
                                    }
                                  : null,
                              child: const Text("Дальше"),
                            )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  bool _isEnabled() {
    final text1 = _nameController.text;
    final text2 = _passController.text;
    final text3 = _passConfirmController.text;
    if ((text1.isEmpty || text2.isEmpty || text3.isEmpty) ||
        text2 != text3 ||
        !enabled) {
      return false;
    }
    return true;
  }
}
