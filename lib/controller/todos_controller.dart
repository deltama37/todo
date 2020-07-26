import 'package:state_notifier/state_notifier.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todos_state.dart';
import 'package:uuid/uuid.dart';

class TodosController extends StateNotifier<TodosState> with LocatorMixin {
  TodosController() : super(const TodosState.loading());

  final _uuid = Uuid();

  @override
  void initState() async {
    super.initState();

    await Future<void>.delayed(const Duration(seconds: 3));

    state = TodosState(
      todos: [
        Todo(id: _uuid.v4(), title: '朝食を食べる'),
        Todo(id: _uuid.v4(), title: 'ラジオ体操をやる'),
        Todo(id: _uuid.v4(), title: '薬を飲む'),
      ],
    );
  }

  void add(String title) {
    final currentState = state;
    if (currentState is TodosStateData) {
      final todos = currentState.todos.toList()
        ..add(
          Todo(id: _uuid.v4(), title: title),
        );
      state = currentState.copyWith(
        todos: todos,
      );
    }
  }

  void toggle(Todo todo) {
    final currentState = state;
    if (currentState is TodosStateData) {
      final clone = currentState.todos.map((t) {
        if (t == todo) {
          return t.copyWith(
            completed: !t.completed,
          );
        }
        return t;
      }).toList();
      state = TodosState(
        todos: clone,
      );
    }
  }
}
