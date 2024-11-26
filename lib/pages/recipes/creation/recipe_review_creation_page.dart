import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/user_recipe/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';

class RecipeReviewCreationPage extends StatefulWidget {
  const RecipeReviewCreationPage({super.key});

  @override
  RecipeReviewCreationPageState createState() => RecipeReviewCreationPageState();
}

class RecipeReviewCreationPageState extends State<RecipeReviewCreationPage> {
  final descriptionTextController = TextEditingController();

  @override
  void dispose() {
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipeBloc, RecipeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${state.recipe?.name}",
                    style: const TextStyle(fontSize: 35),
                  ),
                  Text(
                    "di ${state.recipe?.usernameCreator}",
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.005,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "del 12/19/2000",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          "Punteggio",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: size.width * 0.4,
                    child: Slider(
                      value: state.currentReviewScore?.ceilToDouble() ?? 0.0,
                      onChanged: (value) {
                        context.read<RecipeBloc>().add(SetReviewScore(score: value.toInt()));
                      },
                      max: 5,
                      divisions: 5,
                      label: state.currentReviewScore.toString(),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.1,
                  ),

                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          "Descrizione (facoltativa)",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: descriptionTextController,
                      onChanged: ((value) {
                        context.read<RecipeBloc>().add(SetReviewDescription(
                            description: descriptionTextController.text
                          )
                        );
                      }),
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Descrizione"
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.1,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<RecipeBloc>().add(SaveReviewRequest(
                          usernameReviewCreator: context.read<UserBloc>().state.user!.username
                        )
                      );
                      final router = GoRouter.of(context);
                      router.pop("/recipe/reviews/");
                      descriptionTextController.clear();
                    },
                    child: SizedBox(
                      width: size.width * 0.1,
                      height: size.height * 0.1,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Conferma",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    )
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
