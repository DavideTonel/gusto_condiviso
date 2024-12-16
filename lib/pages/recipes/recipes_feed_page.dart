import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe_creation/recipe_creation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/widgets/recipes/recipe_preview_widget.dart';


class RecipesFeedPage extends StatelessWidget {
  const RecipesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<FeedRecipesBloc, FeedRecipesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: size.width,
              height: 10,
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final router = GoRouter.of(context);
                              router.push("/recipeCreation");
                              context.read<RecipeCreationBloc>().add(LoadAvailableCategoriesRequest());
                              context.read<RecipeCreationBloc>().add(LoadAvailableIngredientsRequest());
                              context.read<RecipeCreationBloc>().add(LoadAvailableToolsRequest());
                            },
                            child: const Text(
                              "Crea Ricetta",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            final router = GoRouter.of(context);
                            router.push("/recipeSearch");
                            context.read<RecipesSearchBloc>().add(LoadAvailableCategoriesForSearchRequest());
                            context.read<RecipesSearchBloc>().add(LoadAvailableIngredientsForSearchRequest());
                            context.read<RecipesSearchBloc>().add(LoadAvailableToolsForSearchRequest());
                          },
                          child: const Text(
                            "Cerca Ricetta",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            context.read<FeedRecipesBloc>().add(
                              LoadRecipesMadeByUserRequest(
                                username: context.read<UserBloc>().state.user!.username
                              )
                            );
                            context.read<FeedRecipesBloc>().add(
                              LoadRecipesSavedByUserRequest(
                                username: context.read<UserBloc>().state.user!.username
                              )
                            );
                          },
                          child: const Text(
                            "Aggiorna Pagina",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: size.width,
              height: 15,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Le mie ricette",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.userRecipes.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: RecipePreviewWidget(
                    name: elem.name,
                    creator: elem.usernameCreator,
                    favorite: state.savedRecipes.map((r) => r.id).contains(elem.id),
                    onFavoritePressed: () {
                      context.read<FeedRecipesBloc>().add(
                        ToggleFavoriteRecipe(
                          recipeId: elem.id,
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );

                      context.read<FeedRecipesBloc>().add(
                        LoadRecipesMadeByUserRequest(
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );

                      context.read<FeedRecipesBloc>().add(
                        LoadRecipesSavedByUserRequest(
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );
                    },
                    onTap: () {
                      context.read<RecipeBloc>().add(LoadRecipeRequest(recipeId: elem.id));
                      final router = GoRouter.of(context);
                      router.push("/recipe");
                    },
                  ),
                )).toList(),
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              //color: Colors.indigo,
              width: size.width,
              //height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ricette salvate",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.35,
              child: ListView(
                children: state.savedRecipes.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: RecipePreviewWidget(
                    name: elem.name,
                    creator: elem.usernameCreator,
                    favorite: state.savedRecipes.map((r) => r.id).contains(elem.id),
                    onFavoritePressed: () {
                      context.read<FeedRecipesBloc>().add(
                        ToggleFavoriteRecipe(
                          recipeId: elem.id,
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );

                      context.read<FeedRecipesBloc>().add(
                        LoadRecipesMadeByUserRequest(
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );

                      context.read<FeedRecipesBloc>().add(
                        LoadRecipesSavedByUserRequest(
                          username: context.read<UserBloc>().state.user!.username
                        )
                      );
                    },
                    onTap: () {
                      context.read<RecipeBloc>().add(LoadRecipeRequest(recipeId: elem.id));
                      final router = GoRouter.of(context);
                      router.push("/recipe");
                    },
                  ),
                )).toList(),
              ),
            ),
            
          ],
        );
      },
    );
  }
}

/*
class RecipesFeedPage extends StatelessWidget {
  const RecipesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationRecipeCreation _:
            final router = GoRouter.of(context);
            router.push("/recipeCreation");
            break;
          default:
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: size.width,
              height: 10,
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<NavigationBloc>().add(NavigateToRecipeCreation());
                              context.read<RecipeCreationBloc>().add(LoadAvailableCategoriesRequest());
                              context.read<RecipeCreationBloc>().add(LoadAvailableIngredientsRequest());
                              context.read<RecipeCreationBloc>().add(LoadAvailableToolsRequest());
                            },
                            child: const Text(
                              "Crea Ricetta",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Cerca Ricetta",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: size.width,
              height: 15,
            ),

            SizedBox(
              //color: Colors.amber,
              width: size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ricette salvate",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              //color: Colors.indigo,
              width: size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ricette con punteggio più alto",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                  RecipePreview(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
*/
