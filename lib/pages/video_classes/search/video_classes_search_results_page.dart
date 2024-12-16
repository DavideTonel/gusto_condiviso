import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_classes_search/video_classes_search_bloc.dart';
import 'package:gusto_condiviso/widgets/video_classes/video_class_preview.dart';

class VideoClassesSearchResultsPage extends StatelessWidget {
  const VideoClassesSearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<VideoClassesSearchBloc, VideoClassesSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<VideoClassesSearchBloc>().add(ClearSearch());
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
                    child: VideoClassPreview(
                      name: elem.name,
                      teacherId: elem.teacherCreatorId,   
                      duration: elem.duration,
                      onTap:() {
                        context.read<VideoClassBloc>().add(
                          LoadVideoClassRequest(
                            videoClassName: elem.name,
                            teacherId: elem.teacherCreatorId
                          )
                        );
                        final router = GoRouter.of(context);
                        router.push("/recipe");
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
