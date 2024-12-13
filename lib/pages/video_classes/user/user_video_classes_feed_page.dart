import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/user/user_video_classes_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
import 'package:gusto_condiviso/widgets/video_classes/video_class_preview.dart';

class UserVideoClassesFeedPage extends StatelessWidget {
  const UserVideoClassesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<UserVideoClassesBloc, UserVideoClassesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: size.width,
              height: 10,
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final router = GoRouter.of(context);
                              router.push("/videoClassCreation");
                            },
                            child: const Text(
                              "Cerca Videolezione",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<UserVideoClassesBloc>().add(
                              LoadVideoClassesFeed()
                            );
                            context.read<UserVideoClassesBloc>().add(
                              LoadVideoClassesStarted(
                                userId: context.read<UserBloc>().state.user!.username
                              )
                            );
                          },
                          child: const Text(
                            "Aggiorna Pagina",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ecco delle lezioni per te",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.feedVideoClasses.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: VideoClassPreview(
                    name: elem.name,
                    teacherId: elem.teacherCreatorId,
                    duration: elem.duration,
                    onTap: () {
                      context.read<VideoClassBloc>().add(
                        LoadVideoClassRequest(
                          teacherId: elem.teacherCreatorId,
                          videoClassName: elem.name
                        )
                      );

                      context.read<UserVideoClassesBloc>().add(
                        GetCurrentVideoPercentageRequest(
                          teacherId: elem.teacherCreatorId,
                          videoClassName: elem.name,
                          userId: context.read<UserBloc>().state.user!.username
                        )
                      );

                      final router = GoRouter.of(context);
                      router.push("/userVideoClass");
                    },
                  ),
                )).toList(),
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Videolezioni visualizzate",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.seenVideoClasses.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: VideoClassPreview(
                    name: elem.name,
                    teacherId: elem.teacherCreatorId,
                    duration: elem.duration,
                    onTap: () {
                      context.read<VideoClassBloc>().add(
                        LoadVideoClassRequest(
                          teacherId: elem.teacherCreatorId,
                          videoClassName: elem.name
                        )
                      );

                      context.read<UserVideoClassesBloc>().add(
                        GetCurrentVideoPercentageRequest(
                          teacherId: elem.teacherCreatorId,
                          videoClassName: elem.name,
                          userId: context.read<UserBloc>().state.user!.username
                        )
                      );
                      
                      final router = GoRouter.of(context);
                      router.push("/userVideoClass");
                    },
                  ),
                )).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
