import 'package:flutter/material.dart';

class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Gusto Condiviso")
          ],
        ),
      ),

      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Benvenuto!\nCon quale profilo vuoi accedere?",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(
            height: 100,
          ),

          SizedBox(
            width: size.width * 0.3,
            height: size.height * 0.1,
            child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                "Utente",
                style: TextStyle(fontSize: 25),
              )
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          SizedBox(
            width: size.width * 0.3,
            height: size.height * 0.1,
            child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                "Insegnante",
                style: TextStyle(fontSize: 25),
              )
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          SizedBox(
            width: size.width * 0.3,
            height: size.height * 0.1,
            child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                "Azienda",
                style: TextStyle(fontSize: 25),
              )
            ),
          )
        ],
      )
    );
  }
}