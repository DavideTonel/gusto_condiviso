import 'package:flutter/material.dart';

class CoursePreviewWidget extends StatelessWidget {
  final int id;
  final String name;
  final String teacherId;
  final VoidCallback onTap;
  //final String date;

  const CoursePreviewWidget(
    {
      super.key,
      required this.id,
      required this.name,
      required this.teacherId,
      required this.onTap
      //required this.date
    }
  );
  

  @override
  Widget build(BuildContext context) {
    return Card (
      child: ListTile(
        title: Text(name),
        subtitle: Text("di $teacherId"),
        //trailing: Text(duration),
        onTap: onTap,
      ),
    );
  }
}