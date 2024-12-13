import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/client/dio_client.dart';
import 'package:gusto_condiviso/model/recipe/tool/tool.dart';
import 'package:meta/meta.dart';

part 'tools_event.dart';
part 'tools_state.dart';

class ToolsBloc extends Bloc<ToolsEvent, ToolsState> {
  ToolsBloc() : super(const ToolsInitial()) {
    on<LoadToolCategories>(onLoadToolCategories);

    on<LoadTools>(onLoadTools);

    on<SaveToolCategory>(onSaveToolCategory);

    on<SaveTool>(onSaveTool);
  }

  FutureOr<void> onLoadToolCategories(
    LoadToolCategories event,
    Emitter<ToolsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/toolCategories"
      ).then((value) {
        List<ToolCategory> categories = [];
        for (dynamic entry in value.data) {
          categories.add(
            ToolCategory(
              id: entry["Codice"] as int,
              name: entry["Nome"] as String
            )
          );
        }

        emit(
          ToolsLoaded(
            availableCategories: categories,
            availableTools: state.availableTools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onLoadTools(
    LoadTools event,
    Emitter<ToolsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/tools"
      ).then((value) {
        List<ToolInfo> tools = [];
        for(dynamic entry in value.data) {
          tools.add(
            ToolInfo(
              name: entry["Nome"] as String,
              category: ToolCategory(
                id: entry["CodiceCategoria"] as int,
                name: entry["NomeCategoria"] as String
              )
            )
          );
        }
        emit(
          ToolsLoaded(
            availableCategories: state.availableCategories,
            availableTools: tools,
          )
        );
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveToolCategory(
    SaveToolCategory event,
    Emitter<ToolsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveToolCategory",
        data: {
          "name": event.name
        }
      ).then((value) async {
        await client.dio.post(
          "api/toolCategories"
        ).then((value) {
          List<ToolCategory> categories = [];
          for (dynamic entry in value.data) {
            categories.add(
              ToolCategory(
                id: entry["Codice"] as int,
                name: entry["Nome"] as String
              )
            );
          }

          emit(
            ToolsLoaded(
              availableCategories: categories,
              availableTools: state.availableTools,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }

  FutureOr<void> onSaveTool(
    SaveTool event,
    Emitter<ToolsState> emit
  ) async {
    try {
      var client = DioClient();
      await client.dio.post(
        "api/saveTool",
        data: {
          "name": event.name,
          "categoryId": event.categoryId
        }
      ).then((value) async {
        await client.dio.post(
          "api/tools"
        ).then((value) {
          List<ToolInfo> tools = [];
          for (dynamic entry in value.data) {
            tools.add(
              ToolInfo(
                name: entry["Nome"] as String,
                category: ToolCategory(
                  id: entry["CodiceCategoria"] as int,
                  name: entry["NomeCategoria"] as String
                )
              )
            );
          }

          emit(
            ToolsLoaded(
              availableCategories: state.availableCategories,
              availableTools: tools,
            )
          );
        });
      });
    } catch (e) {
      dev.log("Error");
      dev.log(e.toString());
    }
  }
}
