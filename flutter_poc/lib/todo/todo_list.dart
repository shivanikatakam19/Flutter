import 'package:flutter/material.dart';
import 'package:flutter_poc/todo/todo_class.dart';
import 'package:flutter_poc/todo/todo_form.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Todo> todos = [
    Todo(
      title: 'good morning',
      description: 'wake up',
      priority: 'High',
      color: Colors.red,
    ),
  ];

  Future<void> _navigateToTodoForm() async {
    final newTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoForm()),
    );

    if (newTodo != null) {
      setState(() {
        todos.add(newTodo); // ✅ add new todo to list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200, // set width
          height: 100, // set height
          child: Text('Todo List'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: todos[index].color,
                      ),
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todos[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(todos[index].description),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(todos[index].priority),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToTodoForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
