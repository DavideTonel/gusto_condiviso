part of 'user_courses_bloc.dart';

@immutable
sealed class UserCoursesState {
  final List<CoursePreview> feedCourses;
  final List<CoursePreview> enrolledCourses;

  final String? currentCourseSavedDate;

  const UserCoursesState(
    {
      required this.feedCourses,
      required this.enrolledCourses,
      required this.currentCourseSavedDate
    }
  );
}

final class UserCoursesInitial extends UserCoursesState {
  const UserCoursesInitial(
    {
      super.feedCourses = const [],
      super.enrolledCourses = const [],
      super.currentCourseSavedDate
    }
  );
}

final class UserCoursesLoaded extends UserCoursesState{
  const UserCoursesLoaded(
    {
      required super.feedCourses,
      required super.enrolledCourses,
      super.currentCourseSavedDate
    }
  );
}