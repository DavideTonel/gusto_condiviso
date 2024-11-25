import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/bloc/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/widgets/recipes/recipe_preview_widget.dart';

class RecipeSearchResultsPage extends StatelessWidget {
  const RecipeSearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipesSearchBloc, RecipesSearchState>(
      listener: (context, state) { 
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<RecipesSearchBloc>().add(ClearSearch());
                final router = GoRouter.of(context);
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)
            ),
            title: const Text("Risultati ricerca"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.4,
                child: ListView(
                  children: state.results
                    .map((elem) => Padding(
                      padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                      child: RecipePreviewWidget(
                        name: elem.name,
                        creator: elem.usernameCreator,
                        favorite: context.read<FeedRecipesBloc>().state.savedRecipes.contains(elem),
                        onFavoritePressed: () {
                          
                        },
                        onTap: () {
                          context
                            .read<RecipeBloc>()
                            .add(LoadRecipeRequest(recipeId: elem.id));
                          final router = GoRouter.of(context);
                          router.push("/recipe");
                        },
                      ),
                      ))
                    .toList(),
                ),
              ),
            ]
          ),
        );
      },
    );
  }
}
