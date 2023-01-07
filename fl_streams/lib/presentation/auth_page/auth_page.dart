import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business/bloc/blocs/auth_bloc.dart';
import '../../business/bloc/events/auth_events.dart';
import '../../business/bloc/states/auth_state.dart';
import '../../common/custom_bloc/bloc_builder.dart';
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
  @override
  Widget build(BuildContext context) {
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
          body: BlocBuilder<AuthBloc, AuthState>(builder: (context, auth) {
            final busy = auth.status == AuthStatus.inProgress;
            if (auth.status == AuthStatus.error) {
              _showSnackBarOnNextFrame(auth.error?.message ?? 'unknown error');
            } else if (auth.status == AuthStatus.loggedIn) {
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
                          context
                              .read<AuthBloc>()
                              .add(AuthLogin(name: name, pass: pass));
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
                          context.read<AuthBloc>().add(AuthRegister(name: name, pass: pass));
                        },
                      ),
              ],
            );
          }),
        ));
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
  void deactivate() {
    super.deactivate();
    final bloc = context.read<AuthBloc>();
    bloc.add(AuthConsumeError());
  }

  void _leaveOnNextFrame() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      Navigator.pop(context);
    });
  }
}
