import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/courses/course_creation/course_creation_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';

class CourseCreationPage extends StatefulWidget {
  const CourseCreationPage({super.key});

  @override
  CourseCreationPageState createState() => CourseCreationPageState();
}

class CourseCreationPageState extends State<CourseCreationPage> {
  final courseNameTextController = TextEditingController();
  final courseDescriptionTextController = TextEditingController();

  final videoClassNameTextController = TextEditingController();
  final videoClassTeacherIdTextController = TextEditingController();

  @override
  void dispose() {
    courseNameTextController.dispose();
    courseDescriptionTextController.dispose();
    videoClassNameTextController.dispose();
    videoClassTeacherIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CourseCreationBloc, CourseCreationState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Creazione Corso",
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
                  controller: courseNameTextController,
                  onChanged: (value) {
                    context.read<CourseCreationBloc>().add(
                      SetCourseNameEvent(name: courseNameTextController.text)
                    );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome corso"
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: courseDescriptionTextController,
                  onChanged: (value) {
                    context.read<CourseCreationBloc>().add(
                      SetCourseDescriptionEvent(description: courseDescriptionTextController.text)
                    );
                  },
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

              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: videoClassNameTextController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nome videolezione"
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.01,
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: videoClassTeacherIdTextController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username insegnante"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: size.width * 0.3,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<CourseCreationBloc>().add(
                              AddVideoClassIfExistsRequest(
                                teacherCreatorId: videoClassTeacherIdTextController.text,
                                videoClassName: videoClassNameTextController.text
                              )
                            );
                            videoClassTeacherIdTextController.clear();
                            videoClassNameTextController.clear();
                          },
                          child: const Text("Aggiungi videolezione")
                        )
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(
                height: size.height * 0.01,
              ),

              Container(
                color: Colors.amber,
                height: size.height * 0.15,
                child: ListView(
                  children: state.videoClasses.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text(elem.name),
                  )).toList(),
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
                          courseNameTextController.text.isNotEmpty &&
                          courseDescriptionTextController.text.isNotEmpty &&
                          state.videoClasses.isNotEmpty
                        ) {
                          context.read<CourseCreationBloc>().add(
                            SaveCourseRequest(
                              teacherCreatorId: context.read<TeacherBloc>().state.teacher!.username,
                            )
                          );
                          final router = GoRouter.of(context);
                          router.pop(); 
                          context.read<CourseCreationBloc>().add(
                            ClearCourseCreationEvent()
                          );
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
