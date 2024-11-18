part of 'user_signin_bloc.dart';

@immutable
sealed class UserSigninEvent {}

final class SigninRequestEvent extends UserSigninEvent {
  final String username;
  final String password;
  final String name;
  final String surname;
  final String mail;
  final String birthday;

  SigninRequestEvent({required this.username, required this.password, required this.name, required this.surname, required this.mail, required this.birthday});
}
