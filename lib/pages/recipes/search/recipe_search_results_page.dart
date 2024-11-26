import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/user_recipe/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/user_recipe/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/user_recipe/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/widgets/recipes/recipe_preview_widget.dart';

class RecipeSearchResultsPage extends StatelessWidget {
  const RecipeSearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipesSearchBloc, RecipesSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<RecipesSearchBloc>().add(ClearSearch());
                  final router = GoRouter.of(context);
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Risultati ricerca"),
          ),
          body: Column(children: [
            ElevatedButton(
                onPressed: () {
                  context.read<FeedRecipesBloc>().add(
                      LoadRecipesSavedByUserRequest(
                          username:
                              context.read<UserBloc>().state.user!.username));
                },
                child: const Text("Aggiorna")),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.results
                  .map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                    child: BlocBuilder<FeedRecipesBloc, FeedRecipesState>(
                      builder: (context, state) {
                        return RecipePreviewWidget(
                          name: elem.name,
                          creator: elem.usernameCreator,
                          favorite: state.savedRecipes.map((e) => e.id).contains(elem.id),
                          onFavoritePressed: () {
                            context.read<FeedRecipesBloc>().add(
                              ToggleFavoriteRecipe(
                                recipeId: elem.id,
                                username: context
                                .read<UserBloc>().state.user!.username
                              )
                            );
                          },
                          onTap: () {
                            context.read<RecipeBloc>().add(
                                LoadRecipeRequest(recipeId: elem.id)
                              );
                            final router = GoRouter.of(context);
                            router.push("/recipe");
                          },
                        );
                      },
                    ),
                  ))
                  .toList(),
              ),
            ),
          ]),
        );
      },
    );
  }
}
