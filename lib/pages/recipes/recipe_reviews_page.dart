import 'package:flutter/material.dart';

class RecipeReviewsPage extends StatelessWidget{
  const RecipeReviewsPage({super.key});

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
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: SizedBox(
          width: size.width * 0.1,
          height: size.height * 0.1,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Scrivi Recensione",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ],
          )
        )
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

          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) => const RecipeReview()
            ),
          )
        ],
      ),
    );
  }
}


class RecipeReview extends StatelessWidget {
  const RecipeReview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom: 10.0),
      child: SizedBox(
        //width: size.width * 0.3,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "4/5",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                    Text(
                      "Franchino DJ",
                      style: TextStyle(
                        fontSize: 22
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
                        "Buona eh.. forse troppe poche patate",
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
                    Flexible(
                      child: Text(
                        "12/30/2024",
                        style: TextStyle(
                          fontSize: 14
                        ),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}