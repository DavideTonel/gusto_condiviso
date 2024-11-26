part of 'teacher_bloc.dart';

@immutable
sealed class TeacherState {
  final Teacher? teacher;

  const TeacherState({required this.teacher});
}

final class TeacherInitial extends TeacherState {
  const TeacherInitial(): super(teacher: null);
}

class TeacherLoaded extends TeacherState {
  const TeacherLoaded({required super.teacher});
}
