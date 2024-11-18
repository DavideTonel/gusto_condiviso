import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gusto_condiviso/widgets/courses/course_preview.dart';

class CoursesFeedPage extends StatefulWidget {

  const CoursesFeedPage({super.key});

  @override
  CoursesFeedPageState createState() => CoursesFeedPageState();
}

class CoursesFeedPageState extends State<CoursesFeedPage> {

  final scrollController = ScrollController();
  final list = List.generate(20, (index) => "Item ${index + 1}");
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMore() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        currentPage++;
        list.addAll(List.generate(20, (index) => "Item ${index + 1}"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        
        SizedBox(
          width: size.width,
          height: 10,
        ),

        SizedBox(
          //color: Colors.indigo,
          width: size.width,
          height: 50,
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Cerca Corso",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          width: size.width,
          height: 15,
        ),

        SizedBox(
          //color: Colors.amber,
          width: size.width,
          height: 70,
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
          width: size.width,
          height: 15,
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListView.builder(
                  controller: scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return const CoursePreview();
                  },
                ),
          ),
        ),
      ],
    );
  }
}