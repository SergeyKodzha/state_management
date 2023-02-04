import 'package:fl_redux/common/widgets/loading_tab.dart';
import 'package:fl_redux/presentation/auth_screen/widgets/login_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../business/redux/actions/auth_actions.dart';
import '../../business/redux/states/app_state.dart';
import '../../business/redux/states/auth.dart';
import 'widgets/register_tab.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _loginName = '';
  String _loginPass = '';
  String _registerName = '';
  String _registerPass = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _leave();
        return false;
      },
      child: DefaultTabController(
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
            body: StoreConnector<AppState, AuthData>(
                distinct: true,
                converter: (store) => store.state.authData,
                builder: (context, auth) {
                  final busy = auth.state == AuthState.inProgress;
                  if (auth.state == AuthState.error) {
                    _showSnackBarOnNextFrame(
                        auth.error?.message ?? 'unknown error');
                  } else if (auth.state == AuthState.authed) {
                    _leaveOnNextFrame();
                    return const Center(
                      child: Text('Вы вошли!'),
                    );
                  }
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

                                StoreProvider.of<AppState>(context)
                                    .dispatch(AuthLoginAction(name, pass));
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

                                StoreProvider.of<AppState>(context)
                                    .dispatch(AuthRegisterAction(name, pass));
                              },
                            ),
                    ],
                  );
                }),
          )),
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

  void _leave() {
    final store = StoreProvider.of<AppState>(context);
    if (store.state.authData.state != AuthState.authed) {
      StoreProvider.of<AppState>(context).dispatch(AuthNotLoggedAction());
    }
    Navigator.pop(context);
  }

  _leaveOnNextFrame() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      _leave();
    });
  }
}
