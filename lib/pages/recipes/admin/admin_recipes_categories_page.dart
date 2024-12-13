import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/categories/recipe_categories_bloc.dart';


class AdminRecipeCategoriesPage extends StatefulWidget {
  const AdminRecipeCategoriesPage({super.key});

  @override
  AdminRecipesCategoriesPageState createState() => AdminRecipesCategoriesPageState();
}

class AdminRecipesCategoriesPageState extends State<AdminRecipeCategoriesPage> {

  final newCategoryNameTextController = TextEditingController();

  @override
  void dispose() {
    newCategoryNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipeCategoriesBloc, RecipeCategoriesState>(
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
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Crea Categoria",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: TextField(
                    controller: newCategoryNameTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), 
                      labelText: "Nome Categoria",
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (
                      newCategoryNameTextController.text.isNotEmpty &&
                      !state.availableCategories.map((e) => e.name).contains(newCategoryNameTextController.text)
                    ) {
                      context.read<RecipeCategoriesBloc>().add(
                        SaveNewCategory(
                          name: newCategoryNameTextController.text
                        )
                      );
                    }
                    newCategoryNameTextController.clear();
                  },
                  child: const Text("Crea")
                )
              ],
            ),

            SizedBox(
              height: size.height * 0.01,
            ),

            SizedBox(
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Categorie Ricette",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.4,
              child: ListView(
                children: state.availableCategories.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    trailing: Text("Codice: ${elem.id.toString()}"),
                  )
                )).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
