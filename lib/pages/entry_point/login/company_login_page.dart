import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/company/company_bloc.dart';
import 'package:gusto_condiviso/bloc/login/company/company_login_bloc.dart';

class CompanyLoginPage extends StatefulWidget {
  const CompanyLoginPage({super.key});

  @override
  CompanyLoginPageState createState() => CompanyLoginPageState();
}

class CompanyLoginPageState extends State<CompanyLoginPage> {

  final companyIdTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    companyIdTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accesso Azienda"),
      ),
      body: Column(
        children: [
          BlocConsumer<CompanyLoginBloc, CompanyLoginState>(
            listener: (context, state) {
              switch (state) {
                case CompanyLoginSuccess _: {
                  context.read<CompanyBloc>().add(SetCompany(company: state.company));
                  final router = GoRouter.of(context);
                  router.push("/companyHome");
                }
                default: {

                }
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: companyIdTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(), 
                          labelText: "Username",
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
                      height: size.height * 0.2,
                    ),
                
                    ElevatedButton(
                      onPressed: () {
                        if (
                          companyIdTextController.text.isNotEmpty &&
                          passwordTextController.text.isNotEmpty
                        ) {
                          context.read<CompanyLoginBloc>().add(
                            LoginRequestEvent(
                              username: companyIdTextController.text,
                              password: passwordTextController.text
                            )
                          );
                        }
                      },
                      child: const Text(
                        "Accedi",
                        style: TextStyle(
                          fontSize: 25
                        ),
                      )
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
