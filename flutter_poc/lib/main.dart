import 'package:flutter/material.dart';
import 'package:flutter_poc/profile_stateless_widget.dart';
import 'package:flutter_poc/todo/todo_form.dart';
import 'package:flutter_poc/todo/todo_list.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ProfileStatelessWidget(),
        '/todoList': (context) => TodoListPage(),
        '/todoForm': (context) => TodoForm(),
      },
    ),
  );
}
