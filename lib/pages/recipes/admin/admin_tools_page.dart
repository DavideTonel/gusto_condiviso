import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/tools/tools_bloc.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';


class AdminToolsPage extends StatefulWidget {
  const AdminToolsPage({super.key});

  @override
  AdminToolsPageState createState() => AdminToolsPageState();
}

class AdminToolsPageState extends State<AdminToolsPage> {

  final newToolCategoryNameTextController = TextEditingController();
  final newToolNameTextController = TextEditingController();
  ToolCategory? newToolCategory;

  @override
  void dispose() {
    newToolCategoryNameTextController.dispose();
    newToolNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<ToolsBloc, ToolsState>(
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
                      controller: newToolCategoryNameTextController,
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
                      newToolCategoryNameTextController.text.isNotEmpty &&
                      !state.availableCategories.map((e) => e.name).contains(newToolCategoryNameTextController.text)
                    ) {
                      context.read<ToolsBloc>().add(SaveToolCategory(
                        name: newToolCategoryNameTextController.text
                      ));
                    }
                    newToolCategoryNameTextController.clear();
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
                      "Crea Utensile",
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
                      controller: newToolNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), 
                        labelText: "Nome Utensile",
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
                              child: DropdownButton2<ToolCategory>(
                                value: newToolCategory,
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.3
                                ),
                                onChanged: (value) {
                                  newToolCategory = value;
                                  setState(() {});
                                },
                                hint: newToolCategory != null
                                  ? Text(newToolCategory!.name)
                                  : const Text("Categoria Utensile"),
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
                if (newToolNameTextController.text.isNotEmpty && newToolCategory != null) {
                    context.read<ToolsBloc>().add(SaveTool(
                      name: newToolNameTextController.text,
                      categoryId: newToolCategory!.id
                    ));
                    newToolNameTextController.clear();
                    newToolCategory = null;
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
                    trailing: IconButton(
                      onPressed: () {
                        context.read<ToolsBloc>().add(
                          DeleteToolCategory(
                            id: elem.id
                          )
                        );
                      },
                      icon: const Icon(Icons.delete)
                    ),
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
                      "Utensili Creati",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.25,
              child: ListView(
                children: state.availableTools.map((elem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    title: Text(elem.name),
                    subtitle: Row(
                      children: [
                        Text("Codice: ${elem.category.id}"),

                        SizedBox(
                          width: size.width * 0.02,
                        ),

                        Text("Categoria: ${elem.category.name}")
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<ToolsBloc>().add(
                          DeleteTool(
                            name: elem.name
                          )
                        );
                      },
                      icon: const Icon(Icons.delete)
                    ),
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
