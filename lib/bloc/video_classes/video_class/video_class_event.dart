part of 'video_class_bloc.dart';

@immutable
sealed class VideoClassEvent {}

final class LoadVideoClassRequest extends VideoClassEvent {
  final String teacherId;
  final String videoClassName;

  LoadVideoClassRequest({required this.teacherId, required this.videoClassName});
}
