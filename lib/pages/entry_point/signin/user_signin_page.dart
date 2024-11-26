import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/signin/user/user_signin_bloc.dart';

class UserSigninPage extends StatefulWidget {
  const UserSigninPage({super.key});

  @override
  UserSigninPageState createState() => UserSigninPageState();
}

class UserSigninPageState extends State<UserSigninPage> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final surnameTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final birthdayTextController = TextEditingController();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    nameTextController.dispose();
    surnameTextController.dispose();
    mailTextController.dispose();
    birthdayTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iscrizione Utente"),
      ),
      body: Column(
        children: [
          BlocConsumer<UserSigninBloc, UserSigninState>(
            listener: (context, state) {
              switch (state) {
                case UserSigninSuccess _:
                  final router = GoRouter.of(context);
                  router.pop();

                case UserSigninFailure _:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SizedBox(
                          width: size.width * 0.4,
                          height: size.height * 0.4,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Username già utilizzato",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ],
                          )
                        ),
                      );
                    }
                  );

                default: {

                }
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: usernameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username"
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: mailTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Mail"
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: passwordTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password"
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: nameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nome"
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: surnameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Cognome"
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: birthdayTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Data di Nascita",
                          helper: Text("YYYY-MM-DD")
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                
                    SizedBox(
                      width: size.width * 0.2,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserSigninBloc>().add(SigninRequestEvent(
                            username: usernameTextController.text,
                            password: passwordTextController.text,
                            name: nameTextController.text,
                            surname: surnameTextController.text,
                            mail: mailTextController.text,
                            birthday: birthdayTextController.text // TODO aggiustare data
                            //birthday: DateTime.now()
                          ));
                        },
                        child: const Text(
                          "Iscriviti",
                          style: TextStyle(
                            fontSize: 22
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
