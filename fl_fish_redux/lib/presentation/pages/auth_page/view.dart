import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/actions.dart';
import 'package:fl_fish_redux/presentation/pages/auth_page/state.dart';
import 'package:flutter/material.dart';

import 'widgets/loading_tab.dart';
import 'widgets/login_tab.dart';
import 'widgets/register_tab.dart';

Widget buildPage(AuthState state, Dispatch dispatch, ViewService viewService) {
  return AuthPageWidget(
      state: state, dispatch: dispatch, viewService: viewService);
}

class AuthPageWidget extends StatefulWidget {
  final AuthState state;
  final Dispatch dispatch;
  final ViewService viewService;
  const AuthPageWidget(
      {Key? key,
      required this.state,
      required this.dispatch,
      required this.viewService})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPageWidget> {
  String _loginName = '';
  String _loginPass = '';
  String _registerName = '';
  String _registerPass = '';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: WillPopScope(
          onWillPop: () async {
            await widget.dispatch(AuthActions.leave(widget.state.user));
            return false;
          },
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
            body: LayoutBuilder(builder: (_, __) {
              final busy = widget.state.status == AuthStatus.processing;
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  busy
                      ? const LoadingTab()
                      : LoginTab(
                          prefilledName: _loginName,
                          prefilledPass: _loginPass,
                          onLogin: (name, pass) {
                            _loginName = name;
                            _loginPass = pass;
                            widget.dispatch(AuthActions.login(name, pass));
                          },
                        ),
                  busy
                      ? const LoadingTab()
                      : RegisterTab(
                          prefilledName: _registerName,
                          prefilledPass: _registerPass,
                          onRegister: (name, pass) {
                            _registerName = name;
                            _registerPass = pass;
                            widget.dispatch(AuthActions.register(name, pass));
                          },
                        ),
                ],
              );
            }),
          ),
        ));
  }
}
