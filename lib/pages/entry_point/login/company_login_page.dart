import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Accesso Azienda")
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 60, right: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height:  size.height*20/100,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username"
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password"
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height*15/100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Accedi")
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    child: const Text("Non hai un account? Iscriviti")
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}