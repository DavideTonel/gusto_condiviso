import 'package:flutter/material.dart';

class VideoClassPreview extends StatelessWidget {
  final String name;
  final String teacherId;
  final String duration;
  final VoidCallback onTap;
  //final String date;

  const VideoClassPreview(
    {
      super.key,
      required this.name,
      required this.teacherId,
      required this.duration,
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
        trailing: Text(duration),
        onTap: onTap,
      ),
    );
  }
}