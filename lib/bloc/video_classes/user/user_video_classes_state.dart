part of 'user_video_classes_bloc.dart';

@immutable
sealed class UserVideoClassesState {
  final List<VideoClass> feedVideoClasses;
  final List<VideoClass> seenVideoClasses;

  final int? currentVideoCompletePercentage;
  final String? currentVideoSavedDate;

  const UserVideoClassesState(
    {
      required this.feedVideoClasses,
      required this.seenVideoClasses,
      required this.currentVideoCompletePercentage,
      required this.currentVideoSavedDate
    }
  );
}

final class UserVideoClassesInitial extends UserVideoClassesState {
  const UserVideoClassesInitial(
    {
      super.feedVideoClasses = const [],
      super.seenVideoClasses = const [],
      super.currentVideoCompletePercentage,
      super.currentVideoSavedDate
    }
  );
}

final class UserVideoClassesLoaded extends UserVideoClassesState{
  const UserVideoClassesLoaded(
    {
      required super.feedVideoClasses,
      required super.seenVideoClasses,
      super.currentVideoCompletePercentage,
      super.currentVideoSavedDate
    }
  );
}
