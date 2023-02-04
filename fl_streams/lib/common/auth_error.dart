import 'package:equatable/equatable.dart';

class AuthError extends Equatable {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
