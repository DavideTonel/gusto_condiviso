part of 'teacher_video_classes_bloc.dart';

@immutable
sealed class TeacherVideoClassesEvent {}

final class LoadVideoClassesMadeByTeacherRequest extends TeacherVideoClassesEvent {
  final String teacherId;

  LoadVideoClassesMadeByTeacherRequest({required this.teacherId});
}

final class SaveVideoClassRequest extends TeacherVideoClassesEvent {
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
}

final class SearchVideoClassRequest extends TeacherVideoClassesEvent {
  final String name;

  SearchVideoClassRequest({required this.name});   
}
