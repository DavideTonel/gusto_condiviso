import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';

import 'dart:developer' as dev;

class VideoClassCreationPage extends StatefulWidget {
  const VideoClassCreationPage({super.key});

  @override
  VideoClassCreationPageState createState() => VideoClassCreationPageState();
}

class VideoClassCreationPageState extends State<VideoClassCreationPage> {
  final classNameTextController = TextEditingController();
  final classDescriptionTextController = TextEditingController();
  final classDurationTextController = TextEditingController();

  @override
  void dispose() {
    classNameTextController.dispose();
    classDescriptionTextController.dispose();
    classDurationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<TeacherVideoClassesBloc, TeacherVideoClassesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Creazione Videolezione",
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: classNameTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome videolezione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: classDescriptionTextController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrizione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: classDurationTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Durata videolezione"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.1,
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (
                          classNameTextController.text.isNotEmpty &&
                          classDescriptionTextController.text.isNotEmpty &&
                          classDurationTextController.text.isNotEmpty
                        ) {
                          context.read<TeacherVideoClassesBloc>().add(
                            SaveVideoClassRequest(
                              teacherId: context.read<TeacherBloc>().state.teacher!.username,
                              name: classNameTextController.text,
                              description: classDescriptionTextController.text,
                              duration: classDurationTextController.text
                            )
                          );
                          final router = GoRouter.of(context);
                          router.pop();  
                        }
                      },
                      child: const Text(
                        "Fine",
                        style: TextStyle(fontSize: 24),
                      )
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ],
                ),
              )
            ]
          )
        );
      },
    );
  }
}
