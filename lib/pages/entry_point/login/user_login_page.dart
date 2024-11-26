import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/login/user/user_login_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<StatefulWidget> createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> {

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
        title: const Text("Accesso Utente"),
      ),
      body: Column(
        children: [
          BlocConsumer<UserLoginBloc, UserLoginState>(
            listener: (context, state) {
              switch (state) {
                case UserLoginSuccess _: {
                  context.read<UserBloc>().add(SetUser(user: state.user));
                  final router = GoRouter.of(context);
                  router.push("/userHome");
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
                        context.read<UserLoginBloc>().add(LoginRequestEvent(
                          username: usernameTextController.text,
                          password: passwordTextController.text)
                        );
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
