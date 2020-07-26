import 'package:state_notifier/state_notifier.dart';
import 'package:todo/model/filtered_todos_state.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todos_state.dart';

class FilteredTodosController extends StateNotifier<FilteredTodosState>
    with LocatorMixin {
  FilteredTodosController() : super(const FilteredTodosState());

  @override
  void update(Locator watch) {
    super.update(watch);

    // TodosStateを監視、stateがTodosStateDataなら更新されたtodosが渡されてくる、そのほかのstateは無視する
    watch<TodosState>().maybeWhen((todos) {
      state = state.copyWith(
        completed: state.completed,
        todos: _filteredTodos(todos, completed: state.completed),
      );
    }, orElse: () => null);
  }

  List<Todo> _filteredTodos(List<Todo> todos, {bool completed}) {
    return todos
        .where((todo) => completed ? todo.completed : !todo.completed)
        .toList();
  }

  void toggle() {
    final completed = !state.completed;
    read<TodosState>().maybeWhen((todos) {
      state = state.copyWith(
        completed: completed,
        todos: _filteredTodos(todos, completed: completed),
      );
    }, orElse: () => null);
  }
}
