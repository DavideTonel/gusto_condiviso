import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/courses/course.dart';
import 'package:gusto_condiviso/model/courses/search/course_search_type.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'courses_search_event.dart';
part 'courses_search_state.dart';

class CoursesSearchBloc extends Bloc<CoursesSearchEvent, CoursesSearchState> {
  CoursesSearchBloc() : super(const CoursesSearchInitial()) {
    on<SetCourseIdEvent>((event, emit) {
      emit(
        CoursesSearchInProgres(
          courseId: event.id,
          courseName: state.courseName,
          teacherId: state.teacherId,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetCourseNameEvent>((event, emit) {
      emit(
        CoursesSearchInProgres(
          courseId: state.courseId,
          courseName: event.name,
          teacherId: state.teacherId,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetTeacherIdEvent>((event, emit) {
      emit(
        CoursesSearchInProgres(
          courseId: state.courseId,
          courseName: state.courseName,
          teacherId: event.id,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetCourseSearchType>((event, emit) {
      emit(
        CoursesSearchInProgres(
          courseId: state.courseId,
          courseName: state.courseName,
          teacherId: state.teacherId,
          results: state.results,
          searchType: event.type
        )
      );
    });

    on<SearchRequest>(onSearchRequest);

    on<ClearSearch>((event, emit) {
      emit(
        const CoursesSearchInitial()
      );
    });
  }

  FutureOr<void> onSearchRequest(
    SearchRequest event,
    Emitter<CoursesSearchState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/searchCourse",
        data: {
          "id": state.courseId,
          "name": state.courseName,
          "teacherId": state.teacherId,
          "searchType": state.searchType.name,
        }
      ).then((value) {
        List<CoursePreview> results = [];
        for(dynamic entry in value.data) {
          results.add(
            CoursePreview(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String,
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String))
            )
          );
        }

        emit(
          CoursesSearchInProgres(
            courseId: state.courseId,
            courseName: state.courseName,
            teacherId: state.teacherId,
            results: results,
            searchType: state.searchType
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
