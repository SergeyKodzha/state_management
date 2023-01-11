import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business/application/auth_model.dart';
import '../../business/application/cart_model.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int curForm = 0;
  bool disabled = false;
  String curName = '';
  String curPass = '';
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    final error = model.error;
    final user = model.user;
    if (user != null) {
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        context.read<CartModel>().fetchCart();
        Navigator.pop(context, true);
      });
    }
    disabled = model.state != AuthState.idle;
    if (error != null) {
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: SizedBox(
                  height: 20, child: Center(child: Text(error.message)))),
        );
        model.consumeError();
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            curForm == 0
                ? LoginForm(
                    name: curName,
                    pass: curPass,
                    enabled: model.state == AuthState.idle,
                    onLogin: (name, pass) {
                      curName = name;
                      curPass = pass;
                      model.login(name, pass);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                : RegisterForm(
                    name: curName,
                    pass: curPass,
                    enabled: model.state == AuthState.idle,
                    onRegister: (name, pass) {
                      curName = name;
                      curPass = pass;
                      model.register(name, pass);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
            _bottomPart()
          ],
        ),
      ),
    );
  }

  Widget _bottomPart() {
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
            _buttonsRow(),
            const SizedBox(height: 32),
          ],
        ),
      );
    }
  }

  Widget _buttonsRow() {
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            onPressed: (curForm == 0)
                ? () {
                    setState(() {
                      curName = '';
                      curPass = '';
                      curForm = 1;
                    });
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
                  onPressed: (curForm == 1)
                      ? () {
                          setState(() {
                            curName = '';
                            curPass = '';
                            curForm = 0;
                          });
                        }
                      : null,
                  child: const Text('Уже есть аккаунт'))),
        ),
      ],
    );
  }
}
