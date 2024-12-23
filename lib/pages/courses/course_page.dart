import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/course/course_bloc.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CourseBloc, CourseState>(
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
                    state.course?.name ?? "nome non disponibile",
                    style: const TextStyle(fontSize: 35),
                  ),

                  Text("(Codice: ${state.course?.id})"),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "di ${state.course?.teacherCreatorId ?? "username non disponibile"}",
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
                      "${state.course?.date}",
                      style: const TextStyle(fontSize: 16),
                    ),
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
                      state.course?.description ?? "descrizione non disponibile",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: state.course?.videoClasses.length ?? 0,
                  itemBuilder: (context, i) => VideoClassInCourseWidget(
                    position: i+1,
                    videoClass: state.course?.videoClasses[i] ?? VideoClass(
                      teacherCreatorId: "",
                      name: "",
                      description: "",
                      date: "",
                      duration: "",
                    ),
                    onTap: () {},
                  )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class VideoClassInCourseWidget extends StatelessWidget {
  final int position;
  final VideoClass videoClass;
  final VoidCallback onTap;

  const VideoClassInCourseWidget(
    {
      super.key,
      required this.position,
      required this.videoClass,
      required this.onTap
    }
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: SizedBox(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Lezione numero $position",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
      
                  SizedBox(
                    height: size.height * 0.002,
                  ),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          videoClass.name,
                          style: const TextStyle(fontSize: 18),
                        )
                      ),
                    ],
                  ),
      
                  SizedBox(
                    height: size.height * 0.002,
                  ),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          videoClass.description,
                          style: const TextStyle(fontSize: 18),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
