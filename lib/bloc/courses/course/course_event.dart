part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

final class LoadCourseRequest extends CourseEvent {
  final int id;

  LoadCourseRequest({required this.id});
}
