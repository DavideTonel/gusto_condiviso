import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/courses/courses_search/courses_search_bloc.dart';
import 'package:gusto_condiviso/model/courses/search/course_search_type.dart';

class CoursesSearchPage extends StatefulWidget {
  const CoursesSearchPage({super.key});

  @override
  CoursesSearchPageState createState() => CoursesSearchPageState();
}

class CoursesSearchPageState extends State<CoursesSearchPage> {
  final courseIdTextController = TextEditingController();
  final courseNameTextController = TextEditingController();
  final teacherIdTextController = TextEditingController();

  @override
  void dispose() {
    courseIdTextController.dispose();
    courseNameTextController.dispose();
    teacherIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<CoursesSearchBloc, CoursesSearchState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ricerca corso"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<CourseSearchType>(
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<CoursesSearchBloc>()
                                  .add(SetCourseSearchType(type: value!)),
                              hint: const Text("Cerca per"),
                              items: CourseSearchType.values
                                  .map((elem) => DropdownMenuItem(
                                      value: elem, child: Text(elem.name)
                                    )
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              if (state.searchType == CourseSearchType.byCodice)
              SizedBox(
                height: size.height * 0.02,
              ),

              if (state.searchType == CourseSearchType.byCodice)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: courseIdTextController,
                  onChanged: (value) {
                    context.read<CoursesSearchBloc>()
                      .add(
                        SetCourseIdEvent(
                          id: courseIdTextController.text
                        )
                      );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Codice corso"
                  ),
                ),
              ),

              if (
                state.searchType == CourseSearchType.byName || 
                state.searchType == CourseSearchType.byNameAndTeacher
              )
              SizedBox(
                height: size.height * 0.02,
              ),

              if (
                state.searchType == CourseSearchType.byName ||
                state.searchType == CourseSearchType.byNameAndTeacher
              )
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: courseNameTextController,
                  onChanged: (value) {
                    context.read<CoursesSearchBloc>()
                      .add(
                        SetCourseNameEvent(
                          name: courseNameTextController.text
                        )
                      );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome corso"
                  ),
                ),
              ),

              if (
                state.searchType == CourseSearchType.byTeacher || 
                state.searchType == CourseSearchType.byNameAndTeacher
              )
              SizedBox(
                height: size.height * 0.02,
              ),

              if (
                state.searchType == CourseSearchType.byTeacher ||
                state.searchType == CourseSearchType.byNameAndTeacher
              )
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: teacherIdTextController,
                  onChanged: (value) {
                    context.read<CoursesSearchBloc>()
                      .add(
                        SetTeacherIdEvent(
                          id: teacherIdTextController.text
                        )
                      );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username insegnante"
                  ),
                ),
              ),

              //if (state.searchType == RecipeSearchType.byTools || state.searchType == RecipeSearchType.byIngredientsAndTools)
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
                          state.courseName != null ||
                          state.teacherId != null ||
                          state.courseId != null
                        ) {
                          context.read<CoursesSearchBloc>().add(SearchRequest());
                          final router = GoRouter.of(context);
                          router.push("/coursesSearch/results");

                          courseIdTextController.clear();
                          courseNameTextController.clear();
                          teacherIdTextController.clear();
                        }
                      },
                      child: const Text(
                        "Cerca",
                        style: TextStyle(fontSize: 24),
                      )
                    ),

                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
