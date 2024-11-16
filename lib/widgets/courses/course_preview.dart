import 'package:flutter/material.dart';

class CoursePreview extends StatelessWidget {
  const CoursePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text("Tutto quello che c'è da sapere sul pesce"),
        subtitle: Text("2 ore e 10 min"),
        trailing: Text("creato da Roberto Carli"),
      ),
    );
  }
}