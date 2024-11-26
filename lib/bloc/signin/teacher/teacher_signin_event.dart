part of 'teacher_signin_bloc.dart';

@immutable
sealed class TeacherSigninEvent {}

final class SigninRequestEvent extends TeacherSigninEvent {
  final String username;
  final String password;
  final String name;
  final String surname;
  final String mail;
  final String birthday;
  final String description;

  SigninRequestEvent(
    {
      required this.username,
      required this.password,
      required this.name,
      required this.surname,
      required this.mail,
      required this.birthday,
      required this.description
    }
  );
}
