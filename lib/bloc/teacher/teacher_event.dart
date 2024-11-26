part of 'teacher_bloc.dart';

@immutable
sealed class TeacherEvent {}

final class SetTeacher extends TeacherEvent {
  final Teacher teacher;

  SetTeacher({required this.teacher});
}