import '../../business/entities/user.dart';

abstract class AuthRepository {
  User? get currentUser;
  Future<User> login(String name, String pass);
  Future<User> register(String name, String pass);
  Future<void> logout();
}
