part of 'video_classes_search_bloc.dart';

@immutable
sealed class VideoClassesSearchEvent {}

final class SetVideoClassNameEvent extends VideoClassesSearchEvent {
  final String name;

  SetVideoClassNameEvent({required this.name});
}

final class SetTeacherIdEvent extends VideoClassesSearchEvent {
  final String id;

  SetTeacherIdEvent({required this.id});
}

final class SetVideoClassSearchType extends VideoClassesSearchEvent {
  final VideoClassSearchType type;

  SetVideoClassSearchType({required this.type});
}

final class SearchRequest extends VideoClassesSearchEvent {}

final class ClearSearch extends VideoClassesSearchEvent {}
