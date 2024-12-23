part of 'courses_search_bloc.dart';

@immutable
sealed class CoursesSearchEvent {}

final class SetCourseIdEvent extends CoursesSearchEvent {
  final String id;

  SetCourseIdEvent({required this.id});
}

final class SetCourseNameEvent extends CoursesSearchEvent {
  final String name;

  SetCourseNameEvent({required this.name});
}

final class SetTeacherIdEvent extends CoursesSearchEvent {
  final String id;

  SetTeacherIdEvent({required this.id});
}

final class SetCourseSearchType extends CoursesSearchEvent {
  final CourseSearchType type;

  SetCourseSearchType({required this.type});
}

final class SearchRequest extends CoursesSearchEvent {}

final class ClearSearch extends CoursesSearchEvent {}

