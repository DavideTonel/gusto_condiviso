part of 'teacher_courses_bloc.dart';

@immutable
sealed class TeacherCoursesState {
  final List<CoursePreview> courses;

  const TeacherCoursesState({required this.courses});
}

final class TeacherCoursesInitial extends TeacherCoursesState {
  const TeacherCoursesInitial(
    {
      super.courses = const []
    }
  );
}

final class TeacherCoursesLoaded extends TeacherCoursesState {
  const TeacherCoursesLoaded({required super.courses});
}