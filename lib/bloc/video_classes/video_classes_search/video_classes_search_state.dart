part of 'video_classes_search_bloc.dart';

@immutable
sealed class VideoClassesSearchState {
  final String? videoClassName;
  final String? teacherId;

  final List<VideoClass> results;

  final VideoClassSearchType searchType;

  const VideoClassesSearchState(
    {
      required this.videoClassName,
      required this.teacherId,
      required this.results,
      required this.searchType
    }
  );
}

final class VideoClassesSearchInitial extends VideoClassesSearchState {
  const VideoClassesSearchInitial(
    {
      super.videoClassName,
      super.teacherId,
      super.results = const [],
      super.searchType = VideoClassSearchType.byName
    }
  );
}

final class VideoClassesSearchInProgres extends VideoClassesSearchState {
  const VideoClassesSearchInProgres(
    {
      required super.videoClassName,
      required super.teacherId,
      required super.results,
      required super.searchType
    }
  );
}
