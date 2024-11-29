import 'package:gusto_condiviso/model/video_classes/video_class.dart';

class Course {
  final int id;
  final String name;
  final String description;
  final String date;
  final String teacherCreatorId;
  final List<VideoClass> videoClasses;

  Course(
    {
      required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.teacherCreatorId,
      required this.videoClasses
    }
  );
}

class CoursePreview {
  final int id;
  final String name;
  final String date;
  final String teacherCreatorId;

  CoursePreview(
    {
      required this.id,
      required this.name,
      required this.date,
      required this.teacherCreatorId,
    }
  );
}