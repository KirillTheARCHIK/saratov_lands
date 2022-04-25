part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String login;
  final String password;

  Login({
    required this.login,
    required this.password,
  });
}

class Logout extends AuthEvent {}

class Registration extends AuthEvent {
  final String login;
  final String password;

  Registration({
    required this.login,
    required this.password,
  });
}
