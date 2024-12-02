import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/signin/teacher/teacher_signin_bloc.dart';

class TeacherSigninPage extends StatefulWidget {
  const TeacherSigninPage({super.key});

  @override
  TeacherSigninPageState createState() => TeacherSigninPageState();
}

class TeacherSigninPageState extends State<TeacherSigninPage> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final surnameTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final birthdayTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    nameTextController.dispose();
    surnameTextController.dispose();
    mailTextController.dispose();
    birthdayTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iscrizione Insegnante"),
      ),
      body: Column(
        children: [
          BlocConsumer<TeacherSigninBloc, TeacherSigninState>(
            listener: (context, state) {
              switch (state) {
                case TeacherSigninSuccess _:
                  final router = GoRouter.of(context);
                  router.pop();

                case TeacherSigninFailure _:
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
                      height: size.height * 0.05,
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
                      height: size.height * 0.02,
                    ),

                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        maxLines: 3,
                        controller: descriptionTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Descrizione",
                        ),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                
                    SizedBox(
                      width: size.width * 0.2,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<TeacherSigninBloc>().add(SigninRequestEvent(
                            username: usernameTextController.text,
                            password: passwordTextController.text,
                            name: nameTextController.text,
                            surname: surnameTextController.text,
                            mail: mailTextController.text,
                            birthday: birthdayTextController.text,
                            description: descriptionTextController.text
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
