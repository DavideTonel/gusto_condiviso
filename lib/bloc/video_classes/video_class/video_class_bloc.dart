import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'video_class_event.dart';
part 'video_class_state.dart';

class VideoClassBloc extends Bloc<VideoClassEvent, VideoClassState> {
  VideoClassBloc() : super(const VideoClassInitial()) {
    on<LoadVideoClassRequest>(onLoadVideoClassRequest);
  }

  FutureOr<void> onLoadVideoClassRequest(
    LoadVideoClassRequest event,
    Emitter<VideoClassState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/videoClass",
        data: {
          "teacherId": event.teacherId,
          "videoClassName": event.videoClassName
        }
      ).then((value) {
        final name = value.data["Nome"] as String;
        final teacherId = value.data["UsernameInsegnante"] as String;
        final description = value.data["Descrizione"] as String;
        final duration = value.data["Durata"] as String;
        final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(value.data["DataPubblicazione"] as String));

        emit(
          VideoClassLoaded(
            videoClass: VideoClass(
            name: name,
            teacherCreatorId: teacherId,
            description: description,
            duration: duration,
            date: date
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
