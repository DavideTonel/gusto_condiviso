import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/courses/course/course_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/user/user_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/user/user_video_classes_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
import 'package:gusto_condiviso/model/video_classes/video_class.dart';
import 'package:gusto_condiviso/pages/courses/course_page.dart';

class UserCoursePage extends StatelessWidget {
  const UserCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.course?.name ?? "nome non disponibile",
                    style: const TextStyle(fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "dell'insegnante ${state.course?.teacherCreatorId ?? "username non disponibile"}",
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
                      state.course?.description ??
                          "descrizione non disponibile",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.2,
              ),

              BlocBuilder<UserCoursesBloc, UserCoursesState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.enrolledCourses
                      .map((c) => c.id)
                      .toList()
                      .contains(context.read<CourseBloc>().state.course?.id)
                    ? null
                    :  () {
                      context.read<UserCoursesBloc>().add(
                        EnrollUserRequest(
                          userId: context.read<UserBloc>().state.user!.username,
                          courseId: context.read<CourseBloc>().state.course!.id
                        )
                      );
                    } ,
                    child: const Text("Segui corso"),
                  );
                },
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
                    onTap: () {
                      context.read<UserVideoClassesBloc>().add(
                        GetCurrentVideoPercentageRequest(
                          teacherId: state.course?.videoClasses[i].teacherCreatorId ?? "",
                          videoClassName: state.course?.videoClasses[i].name?? "",
                          userId: context.read<UserBloc>().state.user!.username
                        )
                      );
                      context.read<VideoClassBloc>().add(
                        LoadVideoClassRequest(
                          teacherId: state.course?.videoClasses[i].teacherCreatorId ?? "",
                          videoClassName: state.course?.videoClasses[i].name?? ""
                        )
                      );
                      final router = GoRouter.of(context);
                      router.push("/userVideoClass");
                    }
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
