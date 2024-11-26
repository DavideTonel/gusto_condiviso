part of 'teacher_login_bloc.dart';

@immutable
sealed class TeacherLoginEvent {}

final class LoginRequestEvent extends TeacherLoginEvent {
  final String username;
  final String password;

  LoginRequestEvent({required this.username, required this.password});
}
