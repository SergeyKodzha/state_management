import 'package:equatable/equatable.dart';

class AuthError extends Equatable{
  final String message;

  const AuthError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}