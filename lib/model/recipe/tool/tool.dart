class Tool {
  final String name;

  Tool({required this.name});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

class ToolCategory {
  final int id;
  final String name;

  ToolCategory({required this.id, required this.name});
}

class ToolInfo {
  final String name;
  final ToolCategory category;

  ToolInfo({required this.name, required this.category});
}
