import 'package:flutter/material.dart';

class RecipeReviewCreationPage extends StatelessWidget{
  const RecipeReviewCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pasta patate e provola",
                style: TextStyle(fontSize: 35),
              ),

              Text(
                "di Carletto Amleto",
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.005,
          ),

          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  "del 12/19/2000",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          
          SizedBox(
            height: size.height * 0.1,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Punteggio",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: size.width * 0.4,
                child: Slider(
                  value: 5,
                  onChanged: (_){},
                  max: 5,
                  divisions: 5,
                  label: 2.round().toString(),
                ),
              ),

              SizedBox(
                height: size.height * 0.1,
              ),

              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Descrizione (facoltativa)",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrizione"
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: size.height * 0.1,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){},
                child: SizedBox(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Conferma",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ],
                  )
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
