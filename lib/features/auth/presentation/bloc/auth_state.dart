part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLoginLoaded extends AuthState {
  final Auth auth;

  AuthLoginLoaded(this.auth);
  @override
  List<Object> get props => [auth];
}

class AuthRegisterLoaded extends AuthState {
  final Auth auth;

  AuthRegisterLoaded(this.auth);
  @override
  List<Object> get props => [auth];
}

class AuthLogoutLoaded extends AuthState {
  final String message;

  AuthLogoutLoaded(this.message);
  @override
  List<Object> get props => [message];
}
