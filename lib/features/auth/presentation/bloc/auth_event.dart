part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthRegisterEvent(this.name, this.email, this.password);
  @override
  List<Object> get props => [name, email, password];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
