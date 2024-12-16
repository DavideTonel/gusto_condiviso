import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/courses/course/course_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/user/user_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/widgets/courses/course_preview.dart';

class UserCoursesFeedPage extends StatelessWidget {
  const UserCoursesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<UserCoursesBloc, UserCoursesState>(
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
                              "Cerca Corso",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<UserCoursesBloc>().add(
                              LoadCoursesFeed()
                            );
                            context.read<UserCoursesBloc>().add(
                              LoadCoursesEnrolled(
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
                      "Ecco dei corsi per te",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.feedCourses.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: CoursePreviewWidget(
                    id: elem.id,
                    name: elem.name,
                    teacherId: elem.teacherCreatorId,
                    onTap: () {
                      context.read<CourseBloc>().add(
                        LoadCourseRequest(
                          id: elem.id
                        )
                      );
                      final router = GoRouter.of(context);
                      router.push("/userCourse");
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
                      "Corsi seguiti",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.enrolledCourses.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: CoursePreviewWidget(
                    id: elem.id,
                    name: elem.name,
                    teacherId: elem.teacherCreatorId,
                    onTap: () {
                      context.read<CourseBloc>().add(
                        LoadCourseRequest(
                          id: elem.id
                        )
                      );
                      final router = GoRouter.of(context);
                      router.push("/userCourse");
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
