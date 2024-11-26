part of 'teacher_signin_bloc.dart';

@immutable
sealed class TeacherSigninState {}

final class TeacherSigninInitial extends TeacherSigninState {}

final class TeacherSigninFailure extends TeacherSigninState {
  final String errorMessage;

  TeacherSigninFailure({required this.errorMessage});
}

final class TeacherSigninSuccess extends TeacherSigninState {}
