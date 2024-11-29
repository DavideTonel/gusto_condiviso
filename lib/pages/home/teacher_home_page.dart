import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/teacher/teacher_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';
import 'package:gusto_condiviso/pages/courses/teacher_courses_page.dart';

import 'dart:developer' as dev;

import 'package:gusto_condiviso/pages/profiles/teacher_profile_page.dart';
import 'package:gusto_condiviso/pages/video_classes/teacher_video_classes_page.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationRailIndex = 0;

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationTeacherHomeProfileInfo _: {
            navigationRailIndex = 0;
          }
          case NavigationTeacherHomeVideoClasses _: {
            navigationRailIndex = 1;
          }
          case NavigationTeacherHomeCourses _: {
            navigationRailIndex = 2;
          }
          default: {
            navigationRailIndex = 0;
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<TeacherBloc, TeacherState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NavigationRail(
                      selectedIndex: navigationRailIndex,
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.account_circle),
                          icon: Icon(Icons.account_circle_outlined),
                          label: Text("Profilo")
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.featured_video),
                          icon: Icon(Icons.featured_video_outlined),
                          label: Text("Lezioni"),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.class_),
                          icon: Icon(Icons.class_outlined),
                          label: Text("Corsi"),
                        ),
                      ],
                      onDestinationSelected: (value) {
                        switch (value) {
                          case 0: {
                            context.read<NavigationBloc>().add(NavigateToTeacherHomeProfileInfo());
                          }
                          case 1: {
                            context.read<NavigationBloc>().add(NavigateToTeacherHomeVideoClasses());
                            context.read<TeacherVideoClassesBloc>().add(LoadVideoClassesMadeByTeacherRequest(
                                teacherId: state.teacher!.username
                              )
                            );
                          }
                          case 2: {
                            context.read<NavigationBloc>().add(NavigateToTeacherHomeCourses());
                            context.read<TeacherCoursesBloc>().add(LoadCoursesMadeByTeacherRequest(
                                teacherId: state.teacher!.username
                              )
                            );
                          }
                          default: {
                            context.read<NavigationBloc>().add(NavigateToTeacherHomeProfileInfo());
                          }
                        }
                      },
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 1,
                  ),
                  Expanded(
                    child: switch (navigationRailIndex) {
                      0 => const TeacherProfilePage(),
                      1 => const TeacherVideoClassesPage(),
                      2 => const TeacherCoursesPage(),
                      _ => const TeacherProfilePage()
                    }
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
