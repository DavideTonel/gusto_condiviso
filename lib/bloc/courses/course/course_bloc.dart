import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/courses/course.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(const CourseInitial()) {
    on<LoadCourseRequest>(onLoadCourseRequest);
  }

  FutureOr<void> onLoadCourseRequest(
    LoadCourseRequest event,
    Emitter<CourseState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/course",
        data: {
          "id": event.id,
        }
      ).then((value) {
        //dev.log(value.data.toString());
        final id = value.data[0]["Codice"] as int;
        final name = value.data[0]["Nome"] as String;
        final teacherId = value.data[0]["UsernameInsegnante"] as String;
        final description = value.data[0]["Descrizione"] as String;
        final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data[0]["DataPubblicazione"] as String));

        final List<VideoClass> videoClasses = [];
        for (var entry in value.data) {
          videoClasses.add(
            VideoClass(
              teacherCreatorId: entry["IdInsegnante"] as String,
              name: entry["NomeVideolezione"] as String,
              description: entry["DescrizioneVideolezione"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataVideolezione"] as String)),
              duration: entry["Durata"] as String
            )
          );
        }

        emit(
          CourseLoaded(
            course: Course(
              id: id,
              name: name,
              teacherCreatorId: teacherId,
              description: description,
              date: date,
              videoClasses: videoClasses
            )
          )
        );
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
