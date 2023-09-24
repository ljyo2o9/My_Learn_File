import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:todolist/view_model/todo_view_model.dart';

class ListCreate extends StatefulWidget {
  const ListCreate({super.key});

  @override
  State<ListCreate> createState() => _ListCreateState();
}

class _ListCreateState extends State<ListCreate> {
  SharedPreferences? _pref;
  List<String> mainList = List.empty(growable: true);
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  Future<void> getInstance() async {
    _pref = await SharedPreferences.getInstance();
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
            //Size(360, 690)
            MaterialButton(
              onPressed: () async {
                mainList.add(textController.text);
                await _pref!.setStringList('mainList', mainList);
                await viewModel.getTodoList();
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
