import 'package:fl_hooks/common/hook_data_container.dart';
import 'package:fl_hooks/common/ui_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../business/application/auth_controller.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthPage extends HookWidget {
  final AuthController authController;
  const AuthPage(this.authController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useListenable(authController.state);
    final curForm=useState<int>(0);
    final curName=useState<String>('');
    final curPass=useState<String>('');
    final disabled=authController.state.value==HookDataState.loading;
    if (authController.state.value ==HookDataState.error) {
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
    if (authController.data!=null){
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
    }
    return Scaffold(
      appBar:AppBar(
        title: const Text('Вход'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            curForm.value==0? LoginForm(
              name: curName.value,
              pass: curPass.value,
              enabled: !disabled,
              onLogin: (name, pass) {
                curName.value = name;
                curPass.value = pass;
                //model.login(name, pass);
                authController.login(curName.value, curPass.value);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ):RegisterForm(
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
            _bottomPart(disabled,curForm,curName,curPass),
          ],
        ),
      ),
    );
  }

  Widget _bottomPart(bool disabled,ValueNotifier<int> curForm,ValueNotifier<String> curName,ValueNotifier<String> curPass) {
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
            _buttonsRow(curForm,curName,curPass),
            const SizedBox(height: 32),
          ],
        ),
      );
    }
  }

  Widget _buttonsRow(ValueNotifier<int> curForm,ValueNotifier<String> curName,ValueNotifier<String> curPass) {
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            onPressed: (curForm.value == 0)
                ? () {
              curName.value='';
              curPass.value='';
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
                    curName.value='';
                    curPass.value='';
                    curForm.value = 0;
                  }
                      : null,
                  child: const Text('Уже есть аккаунт'))),
        ),
      ],
    );
  }
}