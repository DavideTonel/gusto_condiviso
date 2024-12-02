import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'course_creation_event.dart';
part 'course_creation_state.dart';

class CourseCreationBloc extends Bloc<CourseCreationEvent, CourseCreationState> {
  CourseCreationBloc() : super(const CourseCreationInitial()) {
    on<SetCourseNameEvent>((event, emit) {
      emit(
        CourseCreationInProgress(
          name: event.name,
          description: state.description,
          videoClasses: state.videoClasses
        )
      );
    });

    on<SetCourseDescriptionEvent>((event, emit) {
      emit(
        CourseCreationInProgress(
          name: state.name,
          description: event.description,
          videoClasses: state.videoClasses
        )
      );
    });

    on<AddVideoClassIfExistsRequest>(onAddVideoClassIfExistsRequest);

    on<SaveCourseRequest>(onSaveCourseRequest);

    on<ClearCourseCreationEvent>((event, emit) {
      emit(
        const CourseCreationInitial()
      );
    });
  }

  FutureOr<void> onAddVideoClassIfExistsRequest(
    AddVideoClassIfExistsRequest event,
    Emitter<CourseCreationState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/videoClass",
        data: {
          "teacherId": event.teacherCreatorId,
          "videoClassName": event.videoClassName
        }
      ).then((value) {
          final video = VideoClass(
            teacherCreatorId: value.data["UsernameInsegnante"] as String,
            name: value.data["Nome"] as String,
            description: value.data["Descrizione"] as String,
            date: DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataPubblicazione"] as String)),
            duration: value.data["Durata"] as String,
          );

          if (!state.videoClasses.any((elem) => elem.name == video.name && elem.teacherCreatorId == video.teacherCreatorId)) {
            List<VideoClass> newVideoClasses = [...state.videoClasses];
            newVideoClasses.add(video);
            emit(
              CourseCreationInProgress(
                name: state.name,
                description: state.description,
                videoClasses: newVideoClasses
              )
            );
          } else {
            dev.log("Non aggiungo la videolezione");
          }
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveCourseRequest(
    SaveCourseRequest event,
    Emitter<CourseCreationState> emit
  ) async {
    try {
      final client = DioClient();
      await client.dio.post(
        "api/saveCourse",
        data: {
          "teacherId": event.teacherCreatorId,
          "name": state.name,
          "description": state.description,
          "videoClasses": state.videoClasses.map((elem) => elem.toJson()).toList()
        }
      ).then((value) async {
        
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    }
  }
}
