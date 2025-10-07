// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/todos/todo_bloc.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TodoBloc todoBloc = TodoBloc();
  @override
  void initState() {
    todoBloc.add(TodoInitialEvent());
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      bloc: todoBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case TodoLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case TodoLoadedSuccessState:
            return Scaffold(
              appBar: AppBar(title: Text('Todo Page with Dio')),
              body: ListView.builder(
                itemCount: (state as TodoLoadedSuccessState).todoItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text((state).todoItems[index].todo),
                    trailing: (state).todoItems[index].completed
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  );
                },
              ),
            );
          case TodoErrorState:
            return Center(child: Text('Error fetching todos!'));
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
