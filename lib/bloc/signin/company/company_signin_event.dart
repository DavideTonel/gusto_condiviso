part of 'company_signin_bloc.dart';

@immutable
sealed class CompanySigninEvent {}

final class SigninRequestEvent extends CompanySigninEvent {
  final String username;
  final String password;
  final String name;
  final String mail;
  final String linkWebSite;

  SigninRequestEvent(
    {
      required this.username,
      required this.password,
      required this.name,
      required this.mail,
      required this.linkWebSite
    }
  );
}
