import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_classes_search/video_classes_search_bloc.dart';
import 'package:gusto_condiviso/model/video_classes/search/video_class_search_type.dart';

class VideoClassesSearchPage extends StatefulWidget {
  const VideoClassesSearchPage({super.key});

  @override
  VideoClassesSearchPageState createState() => VideoClassesSearchPageState();
}

class VideoClassesSearchPageState extends State<VideoClassesSearchPage> {
  final videoClassNameTextController = TextEditingController();
  final teacherIdTextController = TextEditingController();

  @override
  void dispose() {
    videoClassNameTextController.dispose();
    teacherIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<VideoClassesSearchBloc, VideoClassesSearchState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ricerca videolezione"),
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
                            child: DropdownButton2<VideoClassSearchType>(
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3),
                              onChanged: (value) => context
                                  .read<VideoClassesSearchBloc>()
                                  .add(SetVideoClassSearchType(type: value!)),
                              hint: const Text("Cerca per"),
                              items: VideoClassSearchType.values
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

              if (
                state.searchType == VideoClassSearchType.byName || 
                state.searchType == VideoClassSearchType.byNameAndTeacher
              )
              SizedBox(
                height: size.height * 0.02,
              ),

              if (
                state.searchType == VideoClassSearchType.byName ||
                state.searchType == VideoClassSearchType.byNameAndTeacher
              )
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: videoClassNameTextController,
                  onChanged: (value) {
                    context.read<VideoClassesSearchBloc>()
                      .add(
                        SetVideoClassNameEvent(
                          name: videoClassNameTextController.text
                        )
                      );
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome videolezione"
                  ),
                ),
              ),

              if (
                state.searchType == VideoClassSearchType.byTeacher || 
                state.searchType == VideoClassSearchType.byNameAndTeacher
              )
              SizedBox(
                height: size.height * 0.02,
              ),

              if (
                state.searchType == VideoClassSearchType.byTeacher ||
                state.searchType == VideoClassSearchType.byNameAndTeacher
              )
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: teacherIdTextController,
                  onChanged: (value) {
                    context.read<VideoClassesSearchBloc>()
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
                          state.videoClassName != null || state.teacherId != null
                        ) {
                          context.read<VideoClassesSearchBloc>().add(SearchRequest());
                          final router = GoRouter.of(context);
                          router.push("/videoClassSearch/results");
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
