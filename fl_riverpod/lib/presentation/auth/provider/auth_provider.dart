import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/store_service.dart';
import '../../../common/presentation/provider/repository_provider.dart';
import '../../../common/presentation/provider/store_service_provider.dart';
import '../../../domain/entities/user.dart';

class AuthController extends StateNotifier<AsyncValue<User?>>{
  final StoreService _service;
  AuthController(this._service) : super(const AsyncData(null));
  void login(String name,String pass) async {
    state=const AsyncValue.loading();
    state=await AsyncValue.guard<User?>(() => _service.login(name, pass));

  }

  void register(String name,String pass) async {
    state=const AsyncValue.loading();
    state=await AsyncValue.guard<User?>(() => _service.register(name, pass));
  }
  void logout(){
    _service.logout();
    state=const AsyncValue.data(null);
  }
}

//providers
final authStateProvider=StateNotifierProvider.autoDispose<AuthController,AsyncValue<User?>>((ref) => AuthController(ref.watch(storeServiceProvider)));

final authUserProvider=Provider.autoDispose<User?>((ref) {
  ref.watch(authStateProvider);
  return ref.read(authRepoProvider).currentUser;
});
