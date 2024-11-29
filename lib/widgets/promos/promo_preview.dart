import 'package:flutter/material.dart';

class PromoPreviewWidget extends StatelessWidget {
  final int id;
  final String name;
  //final String description;
  final String endDate;
  //final String useInstructions;
  final VoidCallback onTap;

  const PromoPreviewWidget({super.key, required this.id, required this.name, required this.endDate, required this.onTap});
  //final String date;

  
  

  @override
  Widget build(BuildContext context) {
    return Card (
      child: ListTile(
        title: Text(name),
        //subtitle: Text("di $teacherId"),
        trailing: Text("Scadenza il $endDate"),
        onTap: onTap,
      ),
    );
  }
}