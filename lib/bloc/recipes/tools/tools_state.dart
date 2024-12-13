part of 'tools_bloc.dart';

@immutable
sealed class ToolsState {
  final List<ToolCategory> availableCategories;
  final List<ToolInfo> availableTools;

  const ToolsState(
    {
      required this.availableCategories,
      required this.availableTools
    }
  );
}

final class ToolsInitial extends ToolsState {
  const ToolsInitial(
    {
      super.availableCategories = const [],
      super.availableTools = const []
    }
  );
}

final class ToolsLoaded extends ToolsState {
  const ToolsLoaded({required super.availableCategories, required super.availableTools});
}
