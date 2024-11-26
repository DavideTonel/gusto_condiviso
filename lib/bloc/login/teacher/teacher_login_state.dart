part of 'teacher_login_bloc.dart';

@immutable
sealed class TeacherLoginState {}

final class TeacherLoginInitial extends TeacherLoginState {}

final class TeacherLoginFailure extends TeacherLoginState {
  final String errorMessage;

  TeacherLoginFailure({
    required this.errorMessage
  });
}

final class TeacherLoginSuccess extends TeacherLoginState {
  final Teacher teacher;

  TeacherLoginSuccess({required this.teacher});
}
