import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accesso Compagnia"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username"
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text("Accedi")
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text("Non hai ancora un account? Iscriviti")
              )
            ],
          )
        ],
      ),
    );
  }
}
