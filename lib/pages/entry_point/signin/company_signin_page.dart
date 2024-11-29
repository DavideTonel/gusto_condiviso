import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/signin/company/company_signin_bloc.dart';

class CompanySigninPage extends StatefulWidget {
  const CompanySigninPage({super.key});

  @override
  CompanySigninPageState createState() => CompanySigninPageState();
}

class CompanySigninPageState extends State<CompanySigninPage> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final surnameTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final linkTextController = TextEditingController();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    nameTextController.dispose();
    surnameTextController.dispose();
    mailTextController.dispose();
    linkTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iscrizione Compagnia"),
      ),
      body: Column(
        children: [
          BlocConsumer<CompanySigninBloc, CompanySigninState>(
            listener: (context, state) {
              switch (state) {
                case CompanySigninSuccess _:
                  final router = GoRouter.of(context);
                  router.pop();

                case CompanySigninFailure _:
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
                        controller: linkTextController,
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
                          // TODO check is not blank in every signin and login
                          context.read<CompanySigninBloc>().add(SigninRequestEvent(
                            username: usernameTextController.text,
                            password: passwordTextController.text,
                            name: nameTextController.text,
                            mail: mailTextController.text,
                            linkWebSite: linkTextController.text
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
