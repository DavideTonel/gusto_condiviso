
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe_step_update/recipe_step_update_bloc.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';

class RecipeStepPage extends StatefulWidget {
  const RecipeStepPage({super.key});
  
  @override
  RecipeStepPageState createState() => RecipeStepPageState();
}

class RecipeStepPageState extends State<RecipeStepPage> {
  final selectedQuantityTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void dispose() {
    selectedQuantityTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipeStepUpdateBloc, RecipeStepUpdateState>(
      listener: (context, state) {
        descriptionTextController.text = state.currentStepDescription;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<RecipeStepUpdateBloc>().add(ClearRecipeStep());
                context.read<RecipeBloc>().add(LoadRecipeRequest(recipeId: context.read<RecipeBloc>().state.recipe!.id));
                final router = GoRouter.of(context);
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)
            ) ,
            title: Text(
              "Modifica passaggio ${state.currentStepNumber ?? "0"}",
              style: const TextStyle(fontSize: 25),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),

              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: descriptionTextController,
                        onChanged: (value) {
                          context.read<RecipeStepUpdateBloc>().add(SetDescriptionInCurrentStepEvent(description: value));
                        },
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Descrizione",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (descriptionTextController.text.isNotEmpty) {
                        context.read<RecipeStepUpdateBloc>().add(
                          UpdateDescriptionCurrentStepEvent(
                            description: state.currentStepDescription,
                            stepNumber: state.currentStepNumber!,
                            recipeId: context.read<RecipeBloc>().state.recipe!.id
                          )
                        );
                        descriptionTextController.clear();
                      }
                    },
                    child: const Text("Aggiorna"),
                  ) 
                ],
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              SizedBox(
                width: size.width,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        "Utensili",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<Tool>(
                              value: state.currentToolSelected,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.3
                              ),
                              onChanged: (value) => context
                                .read<RecipeStepUpdateBloc>()
                                .add(SetCurrentToolSelectedEvent(tool: value!)),
                              hint: const Text("Seleziona utensile"),
                              items: state.availableTools
                                .map((elem) => DropdownMenuItem(
                                  value: elem,
                                  child: Text(elem.name)
                                ))
                                .toList(),
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.1,
                          ),

                          ElevatedButton(
                            onPressed: (){
                              if (
                                state.currentToolSelected != null && 
                                !state.currentTools.map((elem) => elem.name).toList().contains(state.currentToolSelected?.name) 
                              ) {
                                context
                                  .read<RecipeStepUpdateBloc>().add(SaveToolInCurrentStepEvent(
                                    toolName: state.currentToolSelected!.name,
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id,
                                    stepNumber: state.currentStepNumber!
                                  ));
                              } else {
                                context
                                  .read<RecipeStepUpdateBloc>().add(RemoveToolFromCurrentStepEvent(
                                    toolName: state.currentToolSelected!.name,
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id,
                                    stepNumber: state.currentStepNumber!
                                  ));
                              }
                            },
                            child: Text(
                              state.currentTools.map((elem) => elem.name).toList().contains(state.currentToolSelected?.name) ? "Rimuovi" : "Aggiungi",
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.grey[350],
                height: size.height * 0.2,
                child: ListView(
                  children: state.currentTools.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text(elem.name),
                  )).toList(),
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              SizedBox(
                width: size.width,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        "Ingredienti",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<Ingredient>(
                              value: state.currentIngredientSelected,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.3
                              ),
                              onChanged: (value) => context
                                .read<RecipeStepUpdateBloc>()
                                .add(SetCurrentIngredientSelectedEvent(ingredient: value!)),
                              hint: const Text("Seleziona ingrediente"),
                              items: state.availableIngredients
                                  .map((elem) => DropdownMenuItem(
                                    value: elem,
                                    child: Text(elem.name),
                                  ))
                                  .toList()
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.05,
                          ),
                      
                          SizedBox(
                            width: size.width * 0.3,
                            child: Flexible(
                              fit: FlexFit.loose,
                              child: TextField(
                                controller: selectedQuantityTextController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Quantità"),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.05,
                          ),
                      
                          ElevatedButton(
                            onPressed: (){
                              if (
                                state.currentIngredientSelected != null && 
                                selectedQuantityTextController.text.isNotEmpty &&
                                !state.currentIngredients.map((elem) => elem.ingredient.name).toList().contains(state.currentIngredientSelected?.name) 
                              ) {
                                context.read<RecipeStepUpdateBloc>().add(
                                  SaveIngredientInCurrentStepEvent(
                                    ingredientName: state.currentIngredientSelected!.name,
                                    amount: selectedQuantityTextController.text,
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id,
                                    stepNumber: state.currentStepNumber!
                                  )
                                );
                                selectedQuantityTextController.clear();
                              } else if (
                                state.currentIngredientSelected != null &&
                                state.currentIngredients.map((elem) => elem.ingredient.name).toList().contains(state.currentIngredientSelected?.name)
                              ) {
                                context.read<RecipeStepUpdateBloc>().add(
                                  RemoveIngredientInCurrentStepEvent(
                                    ingredientName: state.currentIngredientSelected!.name,
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id,
                                    stepNumber: state.currentStepNumber!
                                  )
                                );
                                selectedQuantityTextController.clear();
                              }
                            },
                            child: Text(
                              state.currentIngredients.map((elem) => elem.ingredient.name).toList().contains(state.currentIngredientSelected?.name) ? "Rimuovi" : "Aggiungi",
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              Container(
                color: Colors.grey[350],
                height: size.height * 0.2,
                child: ListView(
                  children: state.currentIngredients.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text("${elem.ingredient.name} ${elem.amount}"),
                  )).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe_step_update/recipe_step_update_bloc.dart';
import 'package:gusto_condiviso/model/recipe/ingredient/ingredient.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';

class RecipeStepPage extends StatefulWidget {
  const RecipeStepPage({super.key});
  
  @override
  RecipeStepPageState createState() => RecipeStepPageState();
}

class RecipeStepPageState extends State<RecipeStepPage> {
  final selectedQuantityTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void dispose() {
    selectedQuantityTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<RecipeStepUpdateBloc, RecipeStepUpdateState>(
      listener: (context, state) {
        descriptionTextController.text = state.currentStepDescription;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<RecipeStepUpdateBloc>().add(ClearRecipeStep());
                final router = GoRouter.of(context);
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)
            ) ,
            title: const Text(
              "Modifica passaggio",
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: descriptionTextController,
                  onChanged: (value) {
                    context.read<RecipeStepUpdateBloc>().add(SetDescriptionInCurrentStepEvent(description: value));
                  },
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrizione",
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              SizedBox(
                width: size.width,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        "Utensili",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<Tool>(
                              value: state.currentToolSelected,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.3
                              ),
                              onChanged: (value) => context
                                .read<RecipeStepUpdateBloc>()
                                .add(SetCurrentToolSelectedEvent(tool: value!)),
                              hint: const Text("Seleziona utensile"),
                              items: state.availableTools
                                .map((elem) => DropdownMenuItem(
                                  value: elem,
                                  child: Text(elem.name)
                                ))
                                .toList(),
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.1,
                          ),

                          ElevatedButton(
                            onPressed: (){
                              if (
                                state.currentToolSelected != null && 
                                !state.currentTools.map((elem) => elem.name).toList().contains(state.currentToolSelected?.name) 
                              ) {
                                context
                                  .read<RecipeStepUpdateBloc>()
                                  .add(SaveToolInCurrentStepEvent());
                              }
                            },
                            child: const Text(
                              "Aggiungi",
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.grey[350],
                height: size.height * 0.2,
                child: ListView(
                  children: state.currentTools.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text(elem.name),
                  )).toList(),
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              SizedBox(
                width: size.width,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        "Ingredienti",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<Ingredient>(
                              value: state.currentIngredientSelected,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.3
                              ),
                              onChanged: (value) => context
                                .read<RecipeStepUpdateBloc>()
                                .add(SetCurrentIngredientSelectedEvent(ingredient: value!)),
                              hint: const Text("Seleziona ingrediente"),
                              items: state.availableIngredients
                                  .map((elem) => DropdownMenuItem(
                                    value: elem,
                                    child: Text(elem.name),
                                  ))
                                  .toList()
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.05,
                          ),
                      
                          SizedBox(
                            width: size.width * 0.3,
                            child: Flexible(
                              fit: FlexFit.loose,
                              child: TextField(
                                controller: selectedQuantityTextController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Quantità"),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.05,
                          ),
                      
                          ElevatedButton(
                            onPressed: (){
                              if (
                                state.currentIngredientSelected != null && 
                                selectedQuantityTextController.text.isNotEmpty &&
                                !state.currentIngredients.map((elem) => elem.ingredient.name).toList().contains(state.currentIngredientSelected?.name) 
                              ) {
                                context
                                  .read<RecipeStepUpdateBloc>()
                                  .add(SaveIngredientInCurrentStepEvent(amount: selectedQuantityTextController.text));
                                  selectedQuantityTextController.clear();
                              }
                            },
                            child: const Text(
                              "Aggiungi",
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              Container(
                color: Colors.grey[350],
                height: size.height * 0.2,
                child: ListView(
                  children: state.currentIngredients.map((elem) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text("${elem.ingredient.name} ${elem.amount}"),
                  )).toList(),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<RecipeStepUpdateBloc>().add(ClearRecipeStep());
                              final router = GoRouter.of(context);
                              router.pop();
                            },
                            child: const Text(
                              "Annulla",
                              style: TextStyle(fontSize: 25),
                            )
                          ),
                          
                          ElevatedButton(
                            onPressed: () {
                              if (
                                state.currentStepDescription.isNotEmpty
                              ) {
                                context.read<RecipeStepUpdateBloc>().add(
                                  UpdateRecipeStepEvent(
                                    stepNumber: state.currentStepNumber!,
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id
                                  )
                                );
                                descriptionTextController.clear();
                                context.read<RecipeStepUpdateBloc>().add(ClearRecipeStep());
                                context.read<RecipeBloc>().add(
                                  LoadRecipeRequest(
                                    recipeId: context.read<RecipeBloc>().state.recipe!.id
                                  )
                                );
                                final router = GoRouter.of(context);
                                router.pop();
                              }
                            },
                            child: const Text(
                              "Aggiorna",
                              style: TextStyle(fontSize: 25),
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

*/