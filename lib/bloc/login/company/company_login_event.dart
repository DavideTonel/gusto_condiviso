part of 'company_login_bloc.dart';

@immutable
sealed class CompanyLoginEvent {}

final class LoginRequestEvent extends CompanyLoginEvent {
  final String username;
  final String password;

  LoginRequestEvent({required this.username, required this.password});
}
