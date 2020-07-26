import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:todo/view/filtered_todo_screen.dart';

import 'controller/filtered_todos_controller.dart';
import 'controller/todos_controller.dart';
import 'model/filtered_todos_state.dart';
import 'model/todos_state.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<TodosController, TodosState>(
      create: (_) => TodosController(),
      child: MaterialApp(
        title: 'State Notifier Todo Demo',
        debugShowCheckedModeBanner: false,
        home:
            StateNotifierProvider<FilteredTodosController, FilteredTodosState>(
          create: (_) => FilteredTodosController(),
          child: FilteredTodosScreen(),
        ),
      ),
    );
  }
}
