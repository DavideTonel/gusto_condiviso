part of 'user_video_classes_bloc.dart';

@immutable
sealed class UserVideoClassesEvent {}

final class LoadVideoClassesFeed extends UserVideoClassesEvent {}

final class LoadVideoClassesStarted extends UserVideoClassesEvent {
  final String userId;

  LoadVideoClassesStarted({required this.userId});
}

final class GetCurrentVideoPercentageRequest extends UserVideoClassesEvent {
  final String teacherId;
  final String videoClassName;
  final String userId;

  GetCurrentVideoPercentageRequest(
    {
      required this.teacherId, 
      required this.videoClassName,
      required this.userId
    }
  );
}

final class ClearCurrentVideoClassPercentage extends UserVideoClassesEvent {}

final class SaveCurrentVideoPercentage extends UserVideoClassesEvent {
  final String teacherId;
  final String videoClassName;
  final String userId;
  final int currentPercentage;

  SaveCurrentVideoPercentage(
    {
      required this.teacherId,
      required this.videoClassName,
      required this.userId,
      required this.currentPercentage
    }
  );
}
