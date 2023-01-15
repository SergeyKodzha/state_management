import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:fl_hooks/common/ui_error.dart';
import 'package:fl_hooks/presentation/auth/widgets/bottom_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../business/application/auth_model.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthPage extends HookWidget {
  final AuthModel authController;
  const AuthPage(this.authController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useListenable(authController.state);
    final curForm = useState<int>(0);
    final curName = useState<String>('');
    final curPass = useState<String>('');
    final disabled = authController.state.value == HookDataState.loading;
    if (authController.state.value == HookDataState.error) {
      final error = authController.error as UIError;
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: SizedBox(
                  height: 20, child: Center(child: Text(error.message)))),
        );
      });
    }
    if (authController.data != null) {
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            curForm.value == 0
                ? LoginForm(
                    name: curName.value,
                    pass: curPass.value,
                    enabled: !disabled,
                    onLogin: (name, pass) {
                      curName.value = name;
                      curPass.value = pass;
                      authController.login(curName.value, curPass.value);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                : RegisterForm(
                    name: curName.value,
                    pass: curPass.value,
                    enabled: !disabled,
                    onRegister: (name, pass) {
                      curName.value = name;
                      curPass.value = pass;
                      authController.register(name, pass);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
            BottomPart(
                disabled: disabled,
                curForm: curForm,
                curName: curName,
                curPass: curPass),
          ],
        ),
      ),
    );
  }
}
