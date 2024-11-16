import 'package:flutter/material.dart';

class PromotionalCodePreview extends StatelessWidget {
  const PromotionalCodePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text("20% di sconto sull'acquisto di pentole"),
        subtitle: Text("Scade il 19/12/2000"),
        trailing: Text("da Thoman"),
      ),
    );
  }
}