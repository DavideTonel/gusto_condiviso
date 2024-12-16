import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';

class RecipeReviewsPage extends StatefulWidget {
  const RecipeReviewsPage({super.key});

  @override
  RecipeReviewsPageState createState() => RecipeReviewsPageState();
}

class RecipeReviewsPageState extends State<RecipeReviewsPage> {

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
                    state.recipe!.name,
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
          floatingActionButton: ElevatedButton(
              onPressed: () {
                final router = GoRouter.of(context);
                router.push("/recipe/reviews/createReview");
              },
              child: SizedBox(
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Scrivi Recensione",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ))),
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
                height: size.height * 0.05,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 35,
                        ),
                        Text(
                          state.recipe!.rating.toString(),
                          style: const TextStyle(fontSize: 30),
                        ),

                        SizedBox(
                          width: size.width * 0.1,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<RecipeBloc>().add(LoadRecipeReviewsRequest(recipeId: state.recipe!.id));
                            context.read<RecipeBloc>().add(LoadRecipeRequest(recipeId: state.recipe!.id));
                          },
                          child: const Text("Aggiorna")
                        )
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    itemCount: state.reviews.length,
                    itemBuilder: (context, i) => RecipeReview(
                      usernameCreator: state.reviews[i].usernameCreator,
                      score: state.reviews[i].score,
                      date: state.reviews[i].date,
                      description: state.reviews[i].description,
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}

class RecipeReview extends StatelessWidget {
  final String usernameCreator;
  final int score;
  final String date;
  final String? description;

  const RecipeReview(
    {
      super.key,
      required this.usernameCreator,
      required this.score,
      required this.date,
      this.description
    }
  ); 
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: SizedBox(
        //width: size.width * 0.3,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$score/5",
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      usernameCreator,
                      style: const TextStyle(fontSize: 22),
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
                      description ?? "",
                      style: const TextStyle(fontSize: 18),
                    )),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      date,
                      style: const TextStyle(fontSize: 14),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
