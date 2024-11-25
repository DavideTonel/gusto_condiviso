import 'package:flutter/material.dart';

class RecipePreviewWidget extends StatelessWidget {
  final String name;
  final String creator;
  final bool favorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const RecipePreviewWidget(
    {
      super.key,
      required this.name,
      required this.creator,
      required this.favorite,
      required this.onTap,
      required this.onFavoritePressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("di $creator"),
        trailing: IconButton(
          onPressed: onFavoritePressed,
          icon: favorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border)
        ),
        onTap: onTap,
      ),
    );
  }
}
