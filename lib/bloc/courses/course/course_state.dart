part of 'course_bloc.dart';

@immutable
sealed class CourseState {
  final Course? course;

  const CourseState ({required this.course});
}

final class CourseInitial extends CourseState {
  const CourseInitial(
    {
      super.course
    }
  );
}

final class CourseLoaded extends CourseState {
  const CourseLoaded(
    {
      required super.course
    }
  );
}