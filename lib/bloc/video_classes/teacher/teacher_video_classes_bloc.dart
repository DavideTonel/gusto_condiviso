import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'teacher_video_classes_event.dart';
part 'teacher_video_classes_state.dart';

class TeacherVideoClassesBloc extends Bloc<TeacherVideoClassesEvent, TeacherVideoClassesState> {
  TeacherVideoClassesBloc() : super(const TeacherVideoClassesInitial()) {
    on<LoadVideoClassesMadeByTeacherRequest>(onLoadVideoClassesMadeByTeacher);

    on<SaveVideoClassRequest>(onSaveVideoClassRequest);

    on<SearchVideoClassRequest>(onSearchVideoClassRequest);
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
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
              duration: entry["Durata"] as String,
            )
          );
        }
        emit(
          TeacherVideoClassesLoaded(
            videoClasses: videoClasses,
            searchedVideoClasses: state.searchedVideoClasses
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
                date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
                duration: entry["Durata"] as String,
              )
            );
          }
          emit(
            TeacherVideoClassesLoaded(
              videoClasses: videoClasses,
              searchedVideoClasses: state.searchedVideoClasses
            )
          );
        });
      });
    } catch (e) {
      dev.log("error");
      dev.log(e.toString());
    } 
  }

  FutureOr<void> onSearchVideoClassRequest(
    SearchVideoClassRequest event,
    Emitter<TeacherVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/searchVideoClass",
        data: {
          "name": event.name
        }
      ).then((value) {
        List<VideoClass> results = [];
        for(dynamic entry in value.data) {
          results.add(
            VideoClass(
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              name: entry["Nome"] as String,
              description: entry["Descrizione"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String)),
              duration: entry["Durata"] as String,
            )
          );
        }
        emit(
          TeacherVideoClassesLoaded(
            videoClasses: state.videoClasses,
            searchedVideoClasses: results
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
