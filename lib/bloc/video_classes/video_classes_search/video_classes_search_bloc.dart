import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/video_classes/search/video_class_search_type.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'video_classes_search_event.dart';
part 'video_classes_search_state.dart';

class VideoClassesSearchBloc extends Bloc<VideoClassesSearchEvent, VideoClassesSearchState> {
  VideoClassesSearchBloc() : super(const VideoClassesSearchInitial()) {
    on<SetVideoClassNameEvent>((event, emit) {
      emit(
        VideoClassesSearchInProgres(
          videoClassName: event.name,
          teacherId: state.teacherId,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetTeacherIdEvent>((event, emit) {
      emit(
        VideoClassesSearchInProgres(
          videoClassName: state.videoClassName,
          teacherId: event.id,
          results: state.results,
          searchType: state.searchType
        )
      );
    });

    on<SetVideoClassSearchType>((event, emit) {
      emit(
        VideoClassesSearchInProgres(
          videoClassName: state.videoClassName,
          teacherId: state.teacherId,
          results: state.results,
          searchType: event.type
        )
      );
    });

    on<SearchRequest>(onSearchRequest);

    on<ClearSearch>((event, emit) {
      emit(
        const VideoClassesSearchInitial()
      );
    });
  }

  FutureOr<void> onSearchRequest(
    SearchRequest event,
    Emitter<VideoClassesSearchState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/searchVideoClass",
        data: {
          "name": state.videoClassName,
          "teacherId": state.teacherId,
          "searchType": state.searchType.name,
        }
      ).then((value) {
        List<VideoClass> results = [];
        for(dynamic entry in value.data) {
          results.add(
            VideoClass(
              name: entry["Nome"] as String,
              teacherCreatorId: entry["UsernameInsegnante"] as String,
              description: entry["Descrizione"] as String,
              duration: entry["Durata"] as String,
              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(entry["DataPubblicazione"] as String))
            )
          );
        }

        emit(
          VideoClassesSearchInProgres(
            videoClassName: state.videoClassName,
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
