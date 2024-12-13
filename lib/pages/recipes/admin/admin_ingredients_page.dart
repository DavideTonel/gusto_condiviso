import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/ingredients/ingredients_bloc.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';


class AdminIngredientsPage extends StatefulWidget {
  const AdminIngredientsPage({super.key});

  @override
  AdminIngredientsPageState createState() => AdminIngredientsPageState();
}

class AdminIngredientsPageState extends State<AdminIngredientsPage> {

  final newIngredientCategoryNameTextController = TextEditingController();
  final newIngredientNameTextController = TextEditingController();
  IngredientCategory? newIngredientCategory;

  @override
  void dispose() {
    newIngredientCategoryNameTextController.dispose();
    newIngredientNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<IngredientsBloc, IngredientsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: newIngredientCategoryNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), 
                        labelText: "Nome Categoria",
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: size.width * 0.03,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (
                      newIngredientCategoryNameTextController.text.isNotEmpty &&
                      !state.availableCategories.map((e) => e.name).contains(newIngredientCategoryNameTextController.text)
                    ) {
                      context.read<IngredientsBloc>().add(SaveIngredientCategory(
                        name: newIngredientCategoryNameTextController.text
                      ));
                    }
                    newIngredientCategoryNameTextController.clear();
                  },
                  child: const Text("Crea")
                )
              ],
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Crea Ingrediente",
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: newIngredientNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), 
                        labelText: "Nome Ingrediente",
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      //width: size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //if (newIngredientCategory == null)
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<IngredientCategory>(
                                value: newIngredientCategory,
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3
                                ),
                                onChanged: (value) {
                                  newIngredientCategory = value;
                                  setState(() {});
                                },
                                hint: newIngredientCategory != null
                                  ? Text(newIngredientCategory!.name)
                                  : const Text("Categoria Ingrediente"),
                                items: state.availableCategories
                                  .map((elem) => DropdownMenuItem(
                                    value: elem,
                                    child: Text(elem.name)
                                  ))
                                  .toList(),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              ),

            SizedBox(
              width: size.width * 0.03,
            ),

            ElevatedButton(
              onPressed: () {
                if (newIngredientNameTextController.text.isNotEmpty && newIngredientCategory != null) {
                    context.read<IngredientsBloc>().add(SaveIngredient(
                      name: newIngredientNameTextController.text,
                      categoryId: newIngredientCategory!.id
                    ));
                    newIngredientNameTextController.clear();
                    newIngredientCategory = null;
                  }
                },
                child: const Text("Crea")
              )
            ],
          ),

            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Categorie Create",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.25,
              child: ListView(
                children: state.availableCategories.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Text(elem.id.toString()),
                  )
                )).toList(),
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              width: size.width,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ingredienti Creati",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.25,
              child: ListView(
                children: state.availableIngredients.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Text(elem.category.name),
                    trailing: Text("Codice: ${elem.category.id}"),
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
