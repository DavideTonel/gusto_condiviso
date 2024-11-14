import 'package:flutter/material.dart';

class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}