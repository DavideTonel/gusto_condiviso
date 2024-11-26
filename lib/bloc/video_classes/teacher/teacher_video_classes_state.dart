part of 'teacher_video_classes_bloc.dart';

@immutable
sealed class TeacherVideoClassesState {
  final List<VideoClass> videoClasses;

  const TeacherVideoClassesState({required this.videoClasses});
}

final class TeacherVideoClassesInitial extends TeacherVideoClassesState {
  const TeacherVideoClassesInitial(
    {
      super.videoClasses = const []
    }
  );
}

final class TeacherVideoClassesLoaded extends TeacherVideoClassesState{
  const TeacherVideoClassesLoaded({required super.videoClasses});
}
