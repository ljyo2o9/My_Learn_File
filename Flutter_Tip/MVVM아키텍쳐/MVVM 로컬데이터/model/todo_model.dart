import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(1, defaultValue: '')
  final String title;

  TodoModel({required this.title});

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(title: map['title']);
  }
}
