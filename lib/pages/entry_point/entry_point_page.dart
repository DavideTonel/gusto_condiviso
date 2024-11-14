import 'package:flutter/material.dart';

class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Gusto Condiviso")
          ],
        ),
      ),

      body: Column(
        //mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  //color: Colors.amberAccent,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.6,
                );
              }
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  //color: Colors.pink,
                  width: constraints.maxWidth,
                  //height: constraints.maxHeight * 0.9,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Benvenuto!\nCon quale profilo vuoi accedere?",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  //color: Colors.amberAccent,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.4,
                );
              }
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  //color: Colors.green,
                  width: constraints.maxWidth,
                  //height: constraints.maxHeight * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Utente",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          ),
                        ),
                        
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Insegnante",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          ),
                        ),

                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Azienda",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ]
      )

      /*
      body: Padding(
        padding: const EdgeInsets.only(top: 200.0, bottom: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Card(
                child: SizedBox(
                  height: 100,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Con quale profilo vuoi accedere?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                )
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => {},
                     child: const SizedBox(
                       height: 50,
                       width: 200,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                             "Utente",
                             style: TextStyle(fontSize: 20),
                           ),
                         ],
                       )
                     )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => {},
                     child: const SizedBox(
                       height: 50,
                       width: 200,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                             "Insegnante",
                             style: TextStyle(fontSize: 20),
                           ),
                         ],
                       )
                     )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => {},
                     child: const SizedBox(
                       height: 50,
                       width: 200,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                             "Azienda",
                             style: TextStyle(fontSize: 20),
                           ),
                         ],
                       )
                     )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      */
    );
  }
}