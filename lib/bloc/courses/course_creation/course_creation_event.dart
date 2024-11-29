part of 'course_creation_bloc.dart';

@immutable
sealed class CourseCreationEvent {}

final class SetCourseNameEvent extends CourseCreationEvent {
  final String name;

  SetCourseNameEvent({required this.name});
}

final class SetCourseDescriptionEvent extends CourseCreationEvent {
  final String description;

  SetCourseDescriptionEvent({required this.description});
}

final class AddVideoClassIfExistsRequest extends CourseCreationEvent {
  final String teacherCreatorId;
  final String videoClassName;

  AddVideoClassIfExistsRequest({required this.teacherCreatorId, required this.videoClassName});
}

final class SaveCourseRequest extends CourseCreationEvent {
  final String teacherCreatorId;

  SaveCourseRequest({required this.teacherCreatorId});
}

final class ClearCourseCreationEvent extends CourseCreationEvent {}