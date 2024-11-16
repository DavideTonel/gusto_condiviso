import 'package:flutter/material.dart';

class RecipeCreationPage extends StatelessWidget {
  const RecipeCreationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Creazione Ricetta",
          
        ),
      ),
      body:  Column(
        children: [

          SizedBox(
            height: size.height * 0.1,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome ricetta"
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.1,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Descrizione"
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.1,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Codice ricetta (se rivisitazione)"
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.15,
          ),

          ElevatedButton(
            onPressed: (){},
            child: const Text(
              "Avanti",
              style: TextStyle(
                fontSize: 24
              ),
            )
          )
        ],
      ),
    );
  }

}