import 'package:flutter/material.dart';

class Todo {
  String title = "";
  String description = "";
  String priority = "";
  Color color;

  Todo({
    required this.title,
    required this.description,
    required this.priority,
    required this.color,
  });
}
