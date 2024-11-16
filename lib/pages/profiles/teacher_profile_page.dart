import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {

  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    //color: Colors.amber,
                    width: size.width,
                    height: 70,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Informazioni Profilo",
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    width: size.width,
                    height: 5,
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Nome: Davide",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Cognome: Tonelli",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Data di nascita: 12/19/2000",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Mail: dav@gmail.com",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Username: davituna",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Password: dav12",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    //color: Colors.indigo,
                    width: size.width,
                    height: 50,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Descrizione: blablablablablablablablabalbalbalbalbalbalbalbalbalba",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }  
}
