part of 'courses_search_bloc.dart';

@immutable
sealed class CoursesSearchState {
  final String? courseId;
  final String? courseName;
  final String? teacherId;

  final List<CoursePreview> results;

  final CourseSearchType searchType;

  const CoursesSearchState(
    {
      required this.courseId,
      required this.courseName,
      required this.teacherId,
      required this.results,
      required this.searchType
    }
  );
}

final class CoursesSearchInitial extends CoursesSearchState {
  const CoursesSearchInitial(
    {
      super.courseId,
      super.courseName,
      super.teacherId,
      super.results = const [],
      super.searchType = CourseSearchType.byName
    }
  );
}

final class CoursesSearchInProgres extends CoursesSearchState {
  const CoursesSearchInProgres(
    {
      required super.courseId,
      required super.courseName,
      required super.teacherId,
      required super.results,
      required super.searchType
    }
  );
}
