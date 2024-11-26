import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/bloc/video_class_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';
import 'package:gusto_condiviso/widgets/video_classes/video_class_preview.dart';


class TeacherVideoClassesPage extends StatelessWidget {
  const TeacherVideoClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<TeacherVideoClassesBloc, TeacherVideoClassesState>(
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
                              "Crea Videolezione",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<TeacherVideoClassesBloc>().add(
                              LoadVideoClassesMadeByTeacherRequest(
                                teacherId: context.read<TeacherBloc>().state.teacher!.username
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
              width: size.width,
              height: 15,
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
                      "Le mie videolezioni",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.videoClasses.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: VideoClassPreview(
                    name: elem.name,
                    teacherId: elem.teacherCreatorId,
                    duration: elem.duration,
                    onTap: () {
                      context.read<VideoClassBloc>().add(
                        LoadVideoClassRequest(
                          teacherId: context.read<TeacherBloc>().state.teacher!.username,
                          videoClassName: elem.name
                        )
                      );
                      final router = GoRouter.of(context);
                      router.push("/videoClass");
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

class TeacherVideoClassesBlocState {
}
