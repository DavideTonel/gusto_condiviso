import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';

import 'dart:developer' as dev;

class VideoClassPage extends StatelessWidget {
  const VideoClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<VideoClassBloc, VideoClassState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.videoClass?.name ?? "nome non disponibile",
                    style: const TextStyle(fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "dell'insegnante ${state.videoClass?.teacherCreatorId ?? "username non disponibile"}",
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.005,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "${state.videoClass?.date}", //TODO aggiungere data
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("Durata: ${state.videoClass?.duration}")
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      state.videoClass?.description ?? "descrizione non disponibile",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
