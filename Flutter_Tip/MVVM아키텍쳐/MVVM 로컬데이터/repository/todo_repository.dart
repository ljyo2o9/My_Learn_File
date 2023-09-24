import 'package:todolist/dataSource/todo_data.dart';

class TodoRepository {
  final TodoDataSource _dataSource = TodoDataSource();

  Future getTodoList() {
    return _dataSource.getTodoList();
  }
}
