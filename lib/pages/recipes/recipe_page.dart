import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/model/recipe/recipe.dart';

// TODO mostrare id ricetta
class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

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
                    state.recipe?.name ?? "nome non disponibile",
                    style: const TextStyle(fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "di ${state.recipe?.usernameCreator ?? "username non disponibile"}",
                      style: const TextStyle(fontSize: 28),
                    ),
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
                      "del 12/19/2000", //TODO aggiungere data
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<RecipeBloc>().add(LoadRecipeReviewsRequest(
                                recipeId: state.recipe!.id
                              )
                            );
                            final router = GoRouter.of(context);
                            router.push("/recipe/reviews");
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 35,
                              ),

                              Text(
                                "4.5",  // TODO aggiungere valutazione
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: size.height * 0.02,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      state.recipe == null || state.recipe?.revisitedRecipeId != null ? "rivisitazione di ${state.recipe?.revisitedRecipeId ?? "non disponibile"}" : "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),
               Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      state.recipe?.description ?? "descrizione non disponibile",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: state.recipe?.steps.length ?? 0,
                  itemBuilder: (context, i) => RecipeStepWidget(
                    stepNumber: i+1,
                    step: state.recipe?.steps[i] ?? RecipeStep(
                      description: "",
                      ingredients: [],
                      tools: []
                    ),
                  )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class RecipeStepWidget extends StatelessWidget {
  final int stepNumber;
  final RecipeStep step;

  const RecipeStepWidget(
    {
      super.key,
      required this.stepNumber,
      required this.step
    }
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: SizedBox(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Passaggio $stepNumber",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),

                SizedBox(
                  height: size.height * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        step.description,
                        style: const TextStyle(fontSize: 18),
                      )
                    ),
                  ],
                ),

                SizedBox(
                  height: size.height * 0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (step.ingredients.isNotEmpty)
                            const Text(
                              "Ingredienti",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: step.ingredients
                            .map((ingredient) {
                              return Text("${ingredient.ingredient.name} ${ingredient.amount}");
                            })
                            .toList(),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: size.height * 0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (step.tools.isNotEmpty)
                        const Text(
                          "Utensili",
                          style: TextStyle(fontSize: 20),
                        ),
                        Column(
                          children: step.tools
                            .map((tool) {
                              //dev.log(tool.name);
                              return Text(tool.name);
                            })
                            .toList(),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
