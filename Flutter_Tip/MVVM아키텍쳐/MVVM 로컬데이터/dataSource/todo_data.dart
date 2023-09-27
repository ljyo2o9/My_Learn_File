import 'package:todolist/model/todo_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

class TodoDataSource {
  Box<TodoModel>? box;

  TodoDataSource() {
    init();
  }

  Future<void> init() async {
    box = Hive.box<TodoModel>('todoList');
  }

  Future<List<TodoModel>> getTodoList() async {
    if (box == null) await init();

    // Hive box는 모든 값을 List로 반환하므로 추가적인 변환이 필요하지 않음
    // hive에서 데이터 전체를 읽어올려면 box.values.toList를 사용함
    final response = box!.values.toList();
    return response;
  }

  Future postTodoList(value) async {
    if (box == null) await init();

    box!.add(TodoModel(title: value));
  }

  Future delTodoList() async {
    if (box == null) await init();

    await box!.clear();
  }
}
