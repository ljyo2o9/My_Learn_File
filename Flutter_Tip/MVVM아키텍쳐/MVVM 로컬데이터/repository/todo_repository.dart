import 'package:todolist/dataSource/todo_data.dart';
import 'package:todolist/model/todo_model.dart';

class TodoRepository {
  final TodoDataSource _dataSource = TodoDataSource();

  Future<List<TodoModel>> getTodoList() {
    return _dataSource.getTodoList();
  }

  Future postTodoList(value) async {
    await _dataSource.postTodoList(value);
  }

  Future delTodoList() async {
    await _dataSource.delTodoList();
  }
}
