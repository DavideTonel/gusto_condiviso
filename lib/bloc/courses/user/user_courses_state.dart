part of 'user_courses_bloc.dart';

@immutable
sealed class UserCoursesState {
  final List<CoursePreview> feedCourses;
  final List<CoursePreview> enrolledCourses;

  //final bool? currentCourseEnrolled;

  const UserCoursesState(
    {
      required this.feedCourses,
      required this.enrolledCourses,
      //required this.currentCourseEnrolled
    }
  );
}

final class UserCoursesInitial extends UserCoursesState {
  const UserCoursesInitial(
    {
      super.feedCourses = const [],
      super.enrolledCourses = const [],
      //super.currentCourseEnrolled
    }
  );
}

final class UserCoursesLoaded extends UserCoursesState{
  const UserCoursesLoaded(
    {
      required super.feedCourses,
      required super.enrolledCourses,
      //super.currentCourseEnrolled
    }
  );
}