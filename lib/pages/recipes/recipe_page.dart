import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget{
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var list = List.generate(6, (i) => i);

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
            height: size.height * 0.05,
          ),

          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 35,
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: size.height * 0.05,
          ),

          const Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Text(
              "Ricetta antichissima che piace a tutti, originaria della Sardegna piace a mia mamma, mia nonna ed il tuo cane.Ricetta antichissima che piace a tutti, originaria della Sardegna piace a mia mamma, mia nonna ed il tuo cane.Ricetta antichissima che piace a tutti, originaria della Sardegna piace a mia mamma, mia nonna ed il tuo cane.Ricetta antichissima che piace a tutti, originaria della Sardegna piace a mia mamma, mia nonna ed il tuo cane.",
              style: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(
            height: size.height * 0.05,
          ),

          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) => const RecipeStepWidget()
            ),
          )
        ],
      ),
    );
  }
}


class RecipeStepWidget extends StatelessWidget {
  const RecipeStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom: 10.0),
      child: SizedBox(
        //width: size.width * 0.9,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Passaggio 1",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  ],
                ),
            
                SizedBox(
                  height: size.height * 0.002,
                ),
                  
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Per prima cosa comprare le patate e della provola, questo servirà più tardi nella ricetta. Ci sono al conad o altrove.Per prima cosa comprare le patate e della provola, questo servirà più tardi nella ricetta. Ci sono al conad o altrove.Per prima cosa comprare le patate e della provola, questo servirà più tardi nella ricetta. Ci sono al conad o altrove.",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      )
                    ),
                  ],
                ),
            
                SizedBox(
                  height: size.height * 0.01,
                ),
                  
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ingredienti",
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ],
                        ),
                        Text("200 patate"),
                        Text("40 provole"),
                        Text("4 kg di pepe"),
                      ],
                    ),
                  ],
                ),
            
                SizedBox(
                  height: size.height * 0.01,
                ),
                  
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Utensili",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text("Schiaccia patate"),
                        Text("Abbati provole"),
                        Text("Macina pepe"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}