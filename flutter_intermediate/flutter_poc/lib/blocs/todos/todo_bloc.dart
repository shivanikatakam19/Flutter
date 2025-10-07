import 'package:bloc/bloc.dart';
import 'package:flutter_poc/models/todo.dart';

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final dio = Dio();
  TodoBloc() : super(TodoInitial()) {
    on<TodoInitialEvent>((event, emit) async {
      try {
        emit(TodoLoadingState());
        final response = await dio.get('https://dummyjson.com/todos');
        if (response.statusCode == 200) {
          final List<dynamic> todosJson = response.data['todos'];
          final todos = todosJson
              .map((json) => TodoItem.fromJson(json))
              .toList();

          emit(TodoLoadedSuccessState(todoItems: todos));
        } else {
          emit(TodoErrorState());
        }
      } catch (e) {
        emit(TodoErrorState());
      }
    });
  }
}
