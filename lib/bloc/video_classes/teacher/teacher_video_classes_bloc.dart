import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:meta/meta.dart';

part 'teacher_video_classes_event.dart';
part 'teacher_video_classes_state.dart';

class TeacherVideoClassesBloc extends Bloc<TeacherVideoClassesEvent, TeacherVideoClassesState> {
  TeacherVideoClassesBloc() : super(const TeacherVideoClassesInitial()) {
    on<LoadVideoClassesMadeByTeacherRequest>(onLoadVideoClassesMadeByTeacher);

    on<SaveVideoClassRequest>(onSaveVideoClassRequest);
  }

  FutureOr<void> onLoadVideoClassesMadeByTeacher(
    LoadVideoClassesMadeByTeacherRequest event,
    Emitter<TeacherVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/videoClassesMadeByTeacher",
        data: {
          "id": event.teacherId
        }
      ).then((value) {
        List<VideoClass> videoClasses = [];
        for(dynamic entry in value.data) {
          videoClasses.add(
            VideoClass(
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              date: entry["DataPubblicazione"] as String,
              duration: entry["Durata"] as String,
            )
          );
        }
        // TODO questo va bene ma controllare tutti gli altri (file) emit che non siano dentro al for
        emit(
          TeacherVideoClassesLoaded(
            videoClasses: videoClasses,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveVideoClassRequest(
    SaveVideoClassRequest event,
    Emitter<TeacherVideoClassesState> emit
  ) async {
    try {
      final client = DioClient();
      await client.dio.post(
        "api/saveVideoClass",
        data: {
          "teacherId": event.teacherId,
          "name": event.name,
          "description": event.description,
          "duration": event.duration,
        }
      ).then((value) async {
        await client.dio.post(
          "api/videoClassesMadeByTeacher",
          data: {
            "id": event.teacherId
          }
        ).then((value) {
          List<VideoClass> videoClasses = [];
          for(dynamic entry in value.data) {
            videoClasses.add(
              VideoClass(
                teacherCreatorId: entry["UsernameInsegnante"] as String,
                name: entry["Nome"] as String,
                description: entry["Descrizione"] as String,
                date: entry["DataPubblicazione"] as String,
                duration: entry["Durata"] as String,
              )
            );
          }
          emit(
            TeacherVideoClassesLoaded(
              videoClasses: videoClasses,
            )
          );
        });
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    } 
  }
}