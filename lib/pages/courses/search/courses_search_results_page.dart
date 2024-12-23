import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/courses/course/course_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/courses_search/courses_search_bloc.dart';
import 'package:gusto_condiviso/widgets/courses/course_preview.dart';

class CoursesSearchResultsPage extends StatelessWidget {
  const CoursesSearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CoursesSearchBloc, CoursesSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<CoursesSearchBloc>().add(ClearSearch());
                  final router = GoRouter.of(context);
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Risultati ricerca"),
          ),
          body: Column(
            children: [
            
            SizedBox(
              height: size.height * 0.1,
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.results
                  .map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    child: CoursePreviewWidget(
                      id: elem.id,
                      name: elem.name,
                      teacherId: elem.teacherCreatorId,   
                      onTap:() {
                        context.read<CourseBloc>().add(
                          LoadCourseRequest(
                            id: elem.id,
                          )
                        );
                        final router = GoRouter.of(context);
                        router.push("/userCourse");
                      },
                    )
                  ),
                ).toList(),
              ),
            ),
          ]),
        );
      },
    );
  }
}
