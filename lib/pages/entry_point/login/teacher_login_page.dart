import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/login/teacher/teacher_login_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';

class TeacherLoginPage extends StatefulWidget {
  const TeacherLoginPage({super.key});

  @override
  State<StatefulWidget> createState() => TeacherLoginPageState();
}

class TeacherLoginPageState extends State<TeacherLoginPage> {

  final teacherTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    teacherTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accesso Insegnante"),
      ),
      body: Column(
        children: [
          BlocConsumer<TeacherLoginBloc, TeacherLoginState>(
            listener: (context, state) {
              switch (state) {
                case TeacherLoginSuccess _: {
                  context.read<TeacherBloc>().add(SetTeacher(teacher: state.teacher));
                  final router = GoRouter.of(context);
                  router.push("/teacherHome");
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
                        controller: teacherTextController,
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
                        context.read<TeacherLoginBloc>().add(LoginRequestEvent(
                          username: teacherTextController.text,
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
