import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class AuthLogin extends AuthEvent {
  final String name;
  final String pass;

  AuthLogin({required this.name, required this.pass});
  
  @override 
  List<Object?> get props => [name, pass];
}

class AuthRegister extends AuthEvent {
  final String name;
  final String pass;

  AuthRegister({required this.name, required this.pass});
  
  @override
  List<Object?> get props => [name, pass];
}

class AuthConsumeError extends AuthEvent {
  @override
  List<Object?> get props => [];
}
