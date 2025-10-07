part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedSuccessState extends TodoState {
  final List<TodoItem> todoItems;

  TodoLoadedSuccessState({required this.todoItems});
}

class TodoErrorState extends TodoState {}
