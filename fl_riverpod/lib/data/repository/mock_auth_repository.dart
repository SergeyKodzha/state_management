import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../application/repository/auth_repository.dart';
import '../../common/error_response.dart';
import '../../domain/entities/user.dart';

class MockAuthRepository implements AuthRepository {
  Future<SharedPreferences> get _sPrefs async => await SharedPreferences.getInstance();
  User? _currentUser;
  @override
  User? get currentUser => _currentUser;
  @override
  Future<User> login(String name, String pass) async {
    await Future.delayed(const Duration(seconds: 2));
    final sPrefs=await _sPrefs;
    final users=sPrefs.getStringList('cached_users')??[];
    for (final json in users){
      final map_user=(jsonDecode(json)) as Map<String,dynamic>;
      if (map_user['name']==name && map_user['pass']==pass) {
        final user=User.fromJson(map_user);
        _currentUser=user;
        return user;
      }
    }
    throw ErrorResponse('user not found');
  }

  @override
  Future<void> logout() async {
    _currentUser=null;
  }

  @override
  Future<User> register(String name, String pass) async {
    await Future.delayed(const Duration(seconds: 2));
    final sPrefs=await _sPrefs;
    final exists=_isExist(sPrefs,name, pass);
    if (exists){
      throw ErrorResponse('user already exists');
    }
    final users=sPrefs.getStringList('cached_users')??[];
    final uid=users.length.toString();
    final mapUser={'uid':uid.toString(),'name': name, 'avatar':'images/avatar.jpg','pass':pass};
    final str=jsonEncode(mapUser);
    users.add(str);
    await sPrefs.setStringList('cached_users',users);
    final newUser=User.fromJson(mapUser);
    _currentUser=newUser;
    return newUser;
  }

  bool _isExist(SharedPreferences sPrefs, String name, String pass) {
    final users=sPrefs.getStringList('cached_users')??[];
    for (final json in users){
      final mapUser=(jsonDecode(json));
      if (mapUser['name']==name && mapUser['pass']==pass) {
        return true;
      }
    }
    return false;
  }
}