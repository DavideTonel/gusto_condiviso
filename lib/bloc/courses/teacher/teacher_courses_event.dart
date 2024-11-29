part of 'teacher_courses_bloc.dart';

@immutable
sealed class TeacherCoursesEvent {}

final class LoadCoursesMadeByTeacherRequest extends TeacherCoursesEvent {
  final String teacherId;

  LoadCoursesMadeByTeacherRequest({required this.teacherId});
}

final class SaveCourseRequest extends TeacherCoursesEvent {
  /*
  final String teacherId;
  final String name;
  final String description;
  final String duration;

  SaveVideoClassRequest(
    {
      required this.teacherId,
      required this.name,
      required this.description,
      required this.duration
    }
  );
  */
}