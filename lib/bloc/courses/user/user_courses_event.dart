part of 'user_courses_bloc.dart';

@immutable
sealed class UserCoursesEvent {}

final class LoadCoursesFeed extends UserCoursesEvent {}

final class LoadCoursesEnrolled extends UserCoursesEvent {
  final String userId;

  LoadCoursesEnrolled({required this.userId});
}

final class EnrollUserRequest extends UserCoursesEvent {
  final String userId;
  final int courseId;

  EnrollUserRequest({required this.userId, required this.courseId});
}