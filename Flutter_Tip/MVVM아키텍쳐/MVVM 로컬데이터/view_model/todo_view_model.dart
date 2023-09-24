import 'package:flutter/widgets.dart';
import 'package:todolist/repository/todo_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();

  List _todoList = List.empty(growable: true);

  List get todoList => _todoList;

  TodoViewModel() {
    getTodoList();
  }

  Future<void> getTodoList() async {
    _todoList = await _todoRepository.getTodoList();
    print(_todoList);
    notifyListeners();
  }
}
