import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev;

part 'user_video_classes_event.dart';
part 'user_video_classes_state.dart';

class UserVideoClassesBloc extends Bloc<UserVideoClassesEvent, UserVideoClassesState> {
  UserVideoClassesBloc() : super(const UserVideoClassesInitial()) {
    on<LoadVideoClassesFeed>(onLoadVideoClassesFeed);

    on<LoadVideoClassesStarted>(onLoadVideoClassesStarted);

    on<SaveCurrentVideoPercentage>(onSaveCurrentVideoPercentage);

    on<GetCurrentVideoPercentageRequest>(onGetCurrentVideoPercentageRequest);

    on<ClearCurrentVideoClassPercentage>((event, emit) {
      emit(
        UserVideoClassesLoaded(
          feedVideoClasses: state.feedVideoClasses,
          seenVideoClasses: state.seenVideoClasses,
        )
      );
    });
  }

  FutureOr<void> onLoadVideoClassesFeed(
    LoadVideoClassesFeed event,
    Emitter<UserVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/videoClassesForUser",
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
          UserVideoClassesLoaded(
            feedVideoClasses: videoClasses,
            seenVideoClasses: state.seenVideoClasses,
            currentVideoCompletePercentage: state.currentVideoCompletePercentage
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadVideoClassesStarted(
    LoadVideoClassesStarted event,
    Emitter<UserVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/videoClassesStartedByUser",
        data: {
          "userId": event.userId
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
          UserVideoClassesLoaded(
            feedVideoClasses: state.feedVideoClasses,
            seenVideoClasses: videoClasses,
            currentVideoCompletePercentage: state.currentVideoCompletePercentage
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveCurrentVideoPercentage(
    SaveCurrentVideoPercentage event,
    Emitter<UserVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveVideoClassMinuteUser", // TODO query
        data: {
          "teacherId": event.teacherId,
          "videoClassName": event.videoClassName,
          "userId": event.userId,
          "completePercentage": event.currentPercentage
        }
      ).then((value) async {
        await client.dio.post(
          "api/getVideoClassMinuteUser", // TODO query
          data: {
            "teacherId": event.teacherId,
            "videoClassName": event.videoClassName,
            "userId": event.userId,
          }
        ).then((value) async {
          emit(
            UserVideoClassesLoaded(
              feedVideoClasses: state.feedVideoClasses,
              seenVideoClasses: state.seenVideoClasses,
              currentVideoCompletePercentage: value.data[0]["MinutoRiproduzione"] as int
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onGetCurrentVideoPercentageRequest(
    GetCurrentVideoPercentageRequest event,
    Emitter<UserVideoClassesState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/getVideoClassMinuteUser", // TODO gestire eliminazione perchè lezione è finita
        data: {
          "teacherId": event.teacherId,
          "videoClassName": event.videoClassName,
          "userId": event.userId,
        }
      ).then((value) async {
        dev.log(value.data.toString());
        emit(
          UserVideoClassesLoaded(
            feedVideoClasses: state.feedVideoClasses,
            seenVideoClasses: state.seenVideoClasses,
            currentVideoCompletePercentage: value.data[0]["MinutoRiproduzione"] as int
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
