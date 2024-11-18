import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';

class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationUserLogin _: {
            final router = GoRouter.of(context);
            router.push("/userLogin");
          }
          case NavigationUserSignin _: {
            final router = GoRouter.of(context);
            router.push("/userSignin");
          }
          default: {

          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [Text("Gusto Condiviso")],
            ),
          ),
          body: SizedBox(
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Benvenuto!\nCon quale profilo vuoi accedere?",
                            style: TextStyle(
                              fontSize: 22
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigateToUserLogin());
                    },
                    child: const Text(
                      "Utente",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    )
                  ),
                ),

                SizedBox(
                  height: size.height * 0.02,
                ),
              
                ElevatedButton(
                  onPressed: () {
                    context.read<NavigationBloc>().add(NavigateToUserSignin());
                  },
                  child: const Text(
                    "Non hai un proflo utente? Iscriviti",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ),

                SizedBox(
                  height: size.width * 0.03,
                ),

                SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Insegnante",
                      style: TextStyle(fontSize: 25),
                    )
                  ),
                ),

                SizedBox(
                  height: size.height * 0.02,
                ),
              
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Non hai un proflo insegante? Iscriviti",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ),

                SizedBox(
                  height: size.width * 0.02,
                ),

                SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Azienda",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    )
                  ),
                ),

                SizedBox(
                  height: size.height * 0.02,
                ),
              
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Non hai ancora un proflo azienda? Iscriviti",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
