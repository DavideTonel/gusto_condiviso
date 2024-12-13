import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/admin/admin_bloc.dart';
import 'package:gusto_condiviso/bloc/login/admin/admin_login_bloc.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLoginPage> {

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accesso Admin"),
      ),
      body: Column(
        children: [
          BlocConsumer<AdminLoginBloc, AdminLoginState>(
            listener: (context, state) {
              switch (state) {
                case AdminLoginSuccess _: {
                  context.read<AdminBloc>().add(SetAdmin(admin: state.admin));
                  final router = GoRouter.of(context);
                  router.push("/adminHome");
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
                        controller: usernameTextController,
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
                          labelText: "Password"),
                      ),
                    ),
                
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                
                    ElevatedButton(
                      onPressed: () {
                        if (
                          usernameTextController.text.isNotEmpty &&
                          passwordTextController.text.isNotEmpty
                        ) {
                          context.read<AdminLoginBloc>().add(LoginRequestEvent(
                            username: usernameTextController.text,
                            password: passwordTextController.text)
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
