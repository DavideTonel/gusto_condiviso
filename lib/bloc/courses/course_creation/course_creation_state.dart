part of 'course_creation_bloc.dart';

@immutable
sealed class CourseCreationState {
  final String? name;
  final String? description;

  final List<VideoClass> videoClasses;

  const CourseCreationState(
    {
      this.name,
      this.description,
      required this.videoClasses
    }
  );
}

final class CourseCreationInitial extends CourseCreationState {
  const CourseCreationInitial(
    {
      super.videoClasses = const []
    }
  );
}

final class CourseCreationInProgress extends CourseCreationState {
  const CourseCreationInProgress(
    {
      super.name,
      super.description,
      required super.videoClasses
    }
  );
}
