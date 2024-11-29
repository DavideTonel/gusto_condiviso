part of 'video_class_bloc.dart';

@immutable
sealed class VideoClassState {
  final VideoClass? videoClass;

  const VideoClassState({required this.videoClass});
}

final class VideoClassInitial extends VideoClassState {
  const VideoClassInitial(
    {
      super.videoClass
    }
  );
}

final class VideoClassLoaded extends VideoClassState {
  const VideoClassLoaded(
    {
      required super.videoClass
    }
  );
}
