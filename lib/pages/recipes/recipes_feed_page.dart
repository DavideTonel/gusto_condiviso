import 'package:flutter/material.dart';
import 'package:gusto_condiviso/widgets/recipes/recipe_preview.dart';

class RecipesFeedPage extends StatelessWidget{
  const RecipesFeedPage({super.key});

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
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Cerca Ricetta",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text(
                        "Crea Ricetta",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
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
                  "Ricette salvate",
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
            ],
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        SizedBox(
          //color: Colors.indigo,
          width: size.width,
          height: 70,
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Ricette con punteggio più alto",
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
              RecipePreview(),
            ],
          ),
        ),
      ],
    );
  }
}