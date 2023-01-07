import 'package:fl_mobx/business/mobx/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widgets/loading_tab.dart';
import 'widgets/login_tab.dart';
import 'widgets/register_tab.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _loginName = '';
  String _loginPass = '';
  String _registerName = '';
  String _registerPass = '';
  final List<ReactionDisposer> reactions=[];
  @override
  void initState() {
    _setupReactions();
    super.initState();
  }
  void _setupReactions(){
    final authStore=context.read<AuthStore>();
    final errorReaction=reaction((_) => authStore.error, (error) {
      if (error!=null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: SizedBox(height: 20, child: Center(child: Text(error.message)))),
        );
      }
    });
    reactions.add(errorReaction);
    //
    final successReaction=reaction((_) => authStore.auth, (auth) {
      final user=auth?.user;
      if (user!=null) {
        Navigator.pop(context);
      }
    });
    reactions.add(successReaction);
  }
  @override
  Widget build(BuildContext context) {
    final authStore=context.read<AuthStore>();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Старый юзер',
                ),
                Tab(
                  icon: Icon(Icons.person_add),
                  text: 'Новый юзер',
                )
              ],
            ),
            title: const Text('Вход'),
          ),
          body: Observer(
            builder:(_) => TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  authStore.state==AuthState.loading
                      ? LoadingTab()
                      : LoginTab(
                          prefilledName: _loginName,
                          prefilledPass: _loginPass,
                          onLogin: (name, pass) {
                            _loginName = name;
                            _loginPass = pass;
                            authStore.login(name, pass);
                          },
                        ),
                  authStore.state==AuthState.loading
                      ? const LoadingTab()
                      : RegisterTab(
                          prefilledName: _registerName,
                          prefilledPass: _registerPass,
                          onRegister: (name, pass) {
                            _registerName = name;
                            _registerPass = pass;
                            authStore.register(name, pass);
                          },
                        ),
                ],
              ),
          ),
          ),
        );
  }

  void _showSnackBarOnNextFrame(String text) {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: SizedBox(height: 20, child: Center(child: Text(text)))),
      );
    });
  }
  @override
  void dispose() {
    for (var rd in reactions) { rd();}
    super.dispose();
  }
}
