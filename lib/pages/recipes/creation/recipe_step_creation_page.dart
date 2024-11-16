import 'package:flutter/material.dart';

class RecipeStepCreationPage extends StatelessWidget {
  const RecipeStepCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Creazione passaggio",
          style: TextStyle(
            fontSize: 25
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Descrizione"
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.05,
          ),

          SizedBox(
            width: size.width,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    "Utensili",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownMenu(
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                            value: "label",
                            label: "prosciutto di capra igp"
                          )
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: size.height * 0.05,
          ),

          SizedBox(
            width: size.width,
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    "Ingredienti",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const DropdownMenu(
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          value: "label",
                          label: "prosciutto di capra igp"
                        )
                      ]
                    ),
                
                    SizedBox(
                      width: size.width * 0.3,
                      child: const Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Quantità"
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: const Text(
                          "Annulla",
                          style: TextStyle(fontSize: 25),
                        )
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: const Text(
                          "Prossimo passaggio",
                          style: TextStyle(fontSize: 25),
                        )
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: const Text(
                          "Fine",
                          style: TextStyle(fontSize: 25),
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}