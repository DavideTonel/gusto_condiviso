import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/user/user_video_classes_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';

class UserVideoClassPage extends StatelessWidget {
  const UserVideoClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<VideoClassBloc, VideoClassState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<UserVideoClassesBloc>().add(ClearCurrentVideoClassPercentage());
                  context.read<UserVideoClassesBloc>().add(ClearCurrentVideoSaveDate());
                  context.read<UserVideoClassesBloc>().add(LoadVideoClassesFeed());
                  context.read<UserVideoClassesBloc>().add(
                    LoadVideoClassesStarted(
                      userId: context.read<UserBloc>().state.user!.username
                    )
                  );
                  final router = GoRouter.of(context);
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
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
                      "Pubblicata il ${state.videoClass?.date}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  if (
                    context.read<UserVideoClassesBloc>().state.seenVideoClasses
                      .where((e) => e.teacherCreatorId == state.videoClass?.teacherCreatorId && e.name == state.videoClass?.name)
                      .toList()
                      .isNotEmpty
                  )
                  BlocBuilder<UserVideoClassesBloc, UserVideoClassesState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          "Salvata il ${state.currentVideoSavedDate}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
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
                      child: Text("Durata: ${state.videoClass?.duration}")),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<UserVideoClassesBloc>().add(
                            DeleteSavedVideoClass(
                                userId: context
                                    .read<UserBloc>()
                                    .state
                                    .user!
                                    .username,
                                teacherId: state.videoClass!.teacherCreatorId,
                                videoClassName: state.videoClass!.name));
                        final router = GoRouter.of(context);
                        router.pop();
                      },
                      child: const Text("Segna completata"))
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
                      state.videoClass?.description ??
                          "descrizione non disponibile",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              BlocBuilder<UserVideoClassesBloc, UserVideoClassesState>(
                builder: (context, state) {
                  return SizedBox(
                    width: size.width * 0.4,
                    child: Slider(
                      value: state.currentVideoCompletePercentage?.toDouble() ??
                          0.0,
                      onChangeEnd: (value) {
                        context.read<UserVideoClassesBloc>().add(
                            SaveCurrentVideoPercentage(
                                teacherId: context
                                        .read<VideoClassBloc>()
                                        .state
                                        .videoClass
                                        ?.teacherCreatorId ??
                                    "",
                                videoClassName: context
                                        .read<VideoClassBloc>()
                                        .state
                                        .videoClass
                                        ?.name ??
                                    "",
                                userId: context
                                    .read<UserBloc>()
                                    .state
                                    .user!
                                    .username,
                                currentPercentage: value.toInt()));
                      },
                      onChanged: (value) {},
                      max: 100,
                      divisions: 100,
                      label: state.currentVideoCompletePercentage.toString(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
