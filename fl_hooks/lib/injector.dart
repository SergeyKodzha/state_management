
import 'business/application/app_service.dart';
import 'data/repositories/mock_auth_repository.dart';
import 'data/repositories/mock_local_repository.dart';
import 'data/repositories/mock_remote_repository.dart';

class Injector{
  static final Injector instance=Injector._internal();
  late AppService appService;
  Injector._internal(){
    _init();
  }
  void _init(){
    appService=AppService(MockAuthRepository(), MockLocalRepository(), MockRemoteRepository());
  }
}