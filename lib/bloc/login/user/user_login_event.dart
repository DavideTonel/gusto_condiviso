part of 'user_login_bloc.dart';

@immutable
sealed class UserLoginEvent {}

final class LoginRequestEvent extends UserLoginEvent {
  final String username;
  final String password;

  LoginRequestEvent({required this.username, required this.password});
}
