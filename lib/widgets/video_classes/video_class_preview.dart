import 'package:flutter/material.dart';

class VideoClassPreview extends StatelessWidget {
  const VideoClassPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card (
      child: ListTile(
        title: Text("Imparare a cucinare i gamberetti"),
        subtitle: Text("30 min"),
        trailing: Text("di Roberto Carli"),
      ),
    );
  }
}