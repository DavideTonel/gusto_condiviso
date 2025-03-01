import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/courses/course.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'user_courses_event.dart';
part 'user_courses_state.dart';

class UserCoursesBloc extends Bloc<UserCoursesEvent, UserCoursesState> {
  UserCoursesBloc() : super(const UserCoursesInitial()) {
    on<LoadCoursesFeed>(onLoadCoursesFeed);

    on<LoadCoursesEnrolled>(onLoadCoursesEnrolled);

    on<EnrollUserRequest>(onEnrollUserRequest);

    on<ClearCurrentCourseSavedDate>((event, emit) {
      emit(
        UserCoursesLoaded(
          feedCourses: state.feedCourses,
          enrolledCourses: state.enrolledCourses,
          currentCourseSavedDate: null
        )
      );
    });

    on<GetCurrentCourseSavedDate>(onGetCurrentCourseSavedDate);
  }

  FutureOr<void> onLoadCoursesFeed(
    LoadCoursesFeed event,
    Emitter<UserCoursesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/coursesForUser",
      ).then((value) {
        List<CoursePreview> courses = [];
        for(dynamic entry in value.data) {
          courses.add(
            CoursePreview(
              id: entry["Codice"] as int,
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              name: entry["Nome"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
            )
          );
        }
        emit(
          UserCoursesLoaded(
            feedCourses: courses,
            enrolledCourses: state.enrolledCourses,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadCoursesEnrolled(
    LoadCoursesEnrolled event,
    Emitter<UserCoursesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/coursesEnrolledUser",
        data: {
          "userId": event.userId
        }
      ).then((value) {
        List<CoursePreview> courses = [];
        for(dynamic entry in value.data) {
          courses.add(
            CoursePreview(
              id: entry["Codice"] as int,
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              name: entry["Nome"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
            )
          );
        }
        emit(
          UserCoursesLoaded(
            feedCourses: state.feedCourses,
            enrolledCourses: courses,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onEnrollUserRequest(
    EnrollUserRequest event,
    Emitter<UserCoursesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/enrollUser",
        data: {
          "userId": event.userId,
          "courseId": event.courseId
        }
      ).then((value) async {
        await client.dio.post(
          "api/coursesEnrolledUser",
          data: {
            "userId": event.userId
          }
        ).then((value) {
          List<CoursePreview> courses = [];
          for(dynamic entry in value.data) {
            courses.add(
              CoursePreview(
                id: entry["Codice"] as int,
                teacherCreatorId: entry["UsernameInsegnante"] as String,
                name: entry["Nome"] as String,
                date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
              )
            );
          }
          emit(
            UserCoursesLoaded(
              feedCourses: state.feedCourses,
              enrolledCourses: courses,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onGetCurrentCourseSavedDate(
    GetCurrentCourseSavedDate event,
    Emitter<UserCoursesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/getCourseSavedDate",
        data: {
          "userId": event.userId,
          "courseId": event.courseId
        }
      ).then((value) {
        emit(
          UserCoursesLoaded(
            feedCourses: state.feedCourses,
            enrolledCourses: state.enrolledCourses,
            currentCourseSavedDate: DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data[0]["DataInizio"] as String))
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
