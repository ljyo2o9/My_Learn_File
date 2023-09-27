// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_model/todo_view_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/todo_model.dart';

class ListCreate extends StatefulWidget {
  const ListCreate({super.key});

  @override
  State<ListCreate> createState() => _ListCreateState();
}

class _ListCreateState extends State<ListCreate> {
  Box<TodoModel>? box;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  Future<void> getInstance() async {
    box = Hive.box('todoList');
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TodoViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Create"),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Container(
                  width: 320.w,
                  height: 420.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 8.h),
                    child: TextField(
                      controller: textController,
                      maxLines: 1000,
                      decoration: const InputDecoration(
                        hintText: '쓸 내용을 입력해주세요',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                if (box == null) await getInstance();

                await viewModel.postTodoList(textController.text);
                await viewModel.getTodoList();

                Navigator.pop(context);
              },
              child: Container(
                width: 320.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '생성하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
