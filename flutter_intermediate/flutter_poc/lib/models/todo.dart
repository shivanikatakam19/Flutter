class TodoItem {
  final int id;
  final String todo;
  final bool completed;

  TodoItem({required this.id, required this.todo, required this.completed});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }
}
