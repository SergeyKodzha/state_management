import 'package:flutter/material.dart';

class LoginTab extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ValueNotifier<bool> btnEnabled = ValueNotifier(false);
  final void Function(String,String)? onLogin;
  LoginTab({Key? key,String? prefilledName,String? prefilledPass, this.onLogin}) : super(key: key){
    _nameController.text=prefilledName??'';
    _passController.text=prefilledPass??'';
    btnEnabled.value=_isBtnEnabled();
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
            'Авторизация',
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
                    ValueListenableBuilder<bool>(
                        valueListenable: btnEnabled,
                        builder: (context, enabled, child) => ElevatedButton(
                              onPressed: !enabled ? null : ()=>onLogin?.call(_nameController.text,_passController.text),
                              child: const Text("авторизоваться"),
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
    if (text1.isEmpty || text2.isEmpty) {
      return false;
    }
    return true;
  }
}
