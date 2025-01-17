part of 'teacher_video_classes_bloc.dart';

@immutable
sealed class TeacherVideoClassesState {
  final List<VideoClass> videoClasses;
  final List<VideoClass> searchedVideoClasses;

  const TeacherVideoClassesState({required this.videoClasses, required this.searchedVideoClasses});
}

final class TeacherVideoClassesInitial extends TeacherVideoClassesState {
  const TeacherVideoClassesInitial(
    {
      super.videoClasses = const [],
      super.searchedVideoClasses = const []
    }
  );
}

final class TeacherVideoClassesLoaded extends TeacherVideoClassesState{
  const TeacherVideoClassesLoaded({required super.videoClasses, required super.searchedVideoClasses});
}
