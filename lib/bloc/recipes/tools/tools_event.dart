part of 'tools_bloc.dart';

@immutable
sealed class ToolsEvent {}

final class LoadToolCategories extends ToolsEvent {}

final class LoadTools extends ToolsEvent {}

final class SaveToolCategory extends ToolsEvent {
  final String name;

  SaveToolCategory({required this.name});
}

final class SaveTool extends ToolsEvent {
  final String name;
  final int categoryId;

  SaveTool(
    {
      required this.name,
      required this.categoryId
    }
  );
}

final class DeleteToolCategory extends ToolsEvent {
  final int id;

  DeleteToolCategory({required this.id});
}

final class DeleteTool extends ToolsEvent {
  final String name;

  DeleteTool({required this.name});
}
