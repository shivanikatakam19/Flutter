import 'package:flutter/material.dart';
import 'package:flutter_poc/todo/todo_class.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  // UI logic and mutable state for this widget will be handled inside _CounterState
  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  String? _selectedPriority = 'Low';
  String _title = "";
  String _description = "";

  @override
  // Every widget must implement the build method
  // build describes what the UI looks like for the current state.
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
      body: Form(
        key: _formGlobalKey,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // todo title
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Title is required'
                      : null;
                },
                onSaved: (newValue) => {_title = newValue!},
              ),

              // todo description
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Description is required'
                      : value.length < 5
                      ? 'Description should be minimum 5 characters'
                      : null;
                },
                onSaved: (newValue) => {_description = newValue!},
              ),

              // todo priority
              DropdownButtonFormField(
                initialValue: _selectedPriority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: <String>["Urgent", "High", "Medium", "Low"].map((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Priority is required'
                      : null;
                },
              ),

              // submit button
              SizedBox(height: 20),
              IconButton.filled(
                onPressed: () {
                  if (_formGlobalKey.currentState!.validate()) {
                    _formGlobalKey.currentState!.save();
                    Navigator.pop(
                      context,
                      Todo(
                        title: _title,
                        description: _description,
                        priority: _selectedPriority ?? "Low",
                        color: _selectedPriority == 'Low'
                            ? Colors.green
                            : _selectedPriority == 'High'
                            ? Colors.amberAccent
                            : _selectedPriority == 'Urgent'
                            ? Colors.red
                            : Colors.orangeAccent,
                      ),
                    );
                    _formGlobalKey.currentState?.reset();
                    _selectedPriority = "Low"; // dropdown back to default
                  }
                },
                icon: Icon(Icons.add),
                color: Colors.white,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
