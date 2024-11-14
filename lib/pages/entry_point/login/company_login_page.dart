import 'package:flutter/material.dart';

class CompanyLoginPage extends StatelessWidget {
  const CompanyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Accesso Azienda")
          ],
        )
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.9,
                );
              }
            ),
          ),

          const Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.only(left: 60.0, right: 60.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username"
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password"
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.2,
                );
              }
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ),
                );
              }
            ),
          )
        ],
      )
    );
  }
}
