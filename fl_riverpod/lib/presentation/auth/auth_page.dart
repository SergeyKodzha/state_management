import 'package:fl_riverpod/presentation/auth/widget/login_form.dart';
import 'package:fl_riverpod/presentation/auth/widget/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/error_response.dart';
import 'provider/auth_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  int curForm = 0;
  bool disabled = false;
  String curName = '';
  String curPass = '';
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    ref.listen(authStateProvider, (_, state) {
      if (!state.isLoading && state.hasError) {
        final error = state.error;
        if (error is ErrorResponse) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: SizedBox(
                    height: 50, child: Center(child: Text(error.message)))),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: SizedBox(
                    height: 50, child: Center(child: Text(error.toString())))),
          );
        }
      }
    });

    ref.listen(authUserProvider, (previous, user) {
      if (user!=null){
        Navigator.pop(context,true);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            curForm != 0
                ? RegisterForm(
                    name: curName,
                    pass: curPass,
                    enabled: !authState.isLoading,
                    onRegister: (name, pass) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        curName = name;
                        curPass = pass;
                        ref
                            .read(authStateProvider.notifier)
                            .register(name, pass);
                        //disabled = true;
                      });
                    },
                  )
                : LoginForm(
                    name: curName,
                    pass: curPass,
                    enabled: !authState.isLoading,
                    onLogin: (name, pass) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        curName = name;
                        curPass = pass;
                        ref.read(authStateProvider.notifier).login(name, pass);
                        //disabled = true;
                      });
                    },
                  ),
            authState.isLoading
                ? Column(mainAxisSize: MainAxisSize.min, children: const [
                    SizedBox(
                      height: 32,
                    ),
                    CircularProgressIndicator()
                  ])
                : _bottomPart(),
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
            _bottomRow(),
            const SizedBox(height: 32),
          ],
        ),
      );
    }
  }

  Widget _bottomRow() {
    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            onPressed: (curForm == 0)
                ? () {
                    setState(() {
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
