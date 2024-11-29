import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/courses/course.dart';
import 'package:meta/meta.dart';

part 'teacher_courses_event.dart';
part 'teacher_courses_state.dart';

class TeacherCoursesBloc extends Bloc<TeacherCoursesEvent, TeacherCoursesState> {
  TeacherCoursesBloc() : super(const TeacherCoursesInitial()) {
    on<LoadCoursesMadeByTeacherRequest>(onLoadCoursesMadeByTeacherRequest);
  }

  FutureOr<void> onLoadCoursesMadeByTeacherRequest(
    LoadCoursesMadeByTeacherRequest event,
    Emitter<TeacherCoursesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/coursesMadeByTeacher",
        data: {
          "id": event.teacherId
        }
      ).then((value) {
        List<CoursePreview> courses = [];
        for(dynamic entry in value.data) {
          courses.add(
            CoursePreview(
              id: entry["Codice"] as int,
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              name: entry["Nome"] as String,
              date: entry["DataPubblicazione"] as String,
            )
          );
        }
        emit(
          TeacherCoursesLoaded(
            courses: courses,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
