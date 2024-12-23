import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';
import 'package:gusto_condiviso/widgets/video_classes/video_class_preview.dart';

class TeacherVideoClassesPage extends StatefulWidget {
  const TeacherVideoClassesPage({super.key});

  @override
  TeacherVideoClassesPageState createState() => TeacherVideoClassesPageState();
}

class TeacherVideoClassesPageState extends State<TeacherVideoClassesPage> {

  final videoClassNameTextController = TextEditingController();

  @override
  void dispose() {
    videoClassNameTextController.dispose();
    super.dispose();
  }

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
              height: size.height * 0.03,
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
              height: size.height * 0.03,
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

            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Cerca videolezioni",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              width: size.width,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: videoClassNameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(), 
                          labelText: "Nome Videolezione",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: size.width * 0.03,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (videoClassNameTextController.text.isNotEmpty) {
                        context.read<TeacherVideoClassesBloc>().add(
                          SearchVideoClassRequest(
                            name: videoClassNameTextController.text
                          )
                        );
                      }
                    },
                    child: const Text("Cerca")
                  )
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.2,
              child: ListView(
                children: state.searchedVideoClasses.map((elem) => Padding(
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
