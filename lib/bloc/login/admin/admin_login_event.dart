part of 'admin_login_bloc.dart';

@immutable
sealed class AdminLoginEvent {}

final class LoginRequestEvent extends AdminLoginEvent {
  final String username;
  final String password;

  LoginRequestEvent({required this.username, required this.password});
}
