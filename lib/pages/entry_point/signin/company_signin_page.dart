import 'package:flutter/material.dart';

class CompanySigninPage extends StatelessWidget {
  const CompanySigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iscrizione Azienda"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
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
                      labelText: "Mail"
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
                  height: 40,
                ),
                  
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome"
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
                      labelText: "Link sito aziendale"
                    ),
                  ),
                ),
                  
                const SizedBox(
                  height: 50,
                ),
                  
                SizedBox(
                  width: size.width * 0.2,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: const Text(
                      "Iscriviti",
                      style: TextStyle(fontSize: 22),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
