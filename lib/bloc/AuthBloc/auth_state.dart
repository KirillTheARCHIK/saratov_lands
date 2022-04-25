part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class Unauthorized extends AuthState {}

class UnauthorizedWithError extends AuthState {
  late final String errorText;

  UnauthorizedWithError(AuthExeptions error) {
    switch (error) {
      case AuthExeptions.noUser:
        {
          errorText = 'Такого пользователя нет';
          break;
        }
      case AuthExeptions.wrongPassword:
        {
          errorText = 'Неправильный пароль';
          break;
        }
      default:
        {
          errorText = 'Неизвестная ошибка';
          break;
        }
    }
  }
}

class Authorized extends AuthState {
  final User user;

  Authorized({
    required this.user,
  });
}
