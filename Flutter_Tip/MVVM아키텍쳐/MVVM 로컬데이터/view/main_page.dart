import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todolist/view/create.dart';
import 'package:todolist/view_model/todo_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TodoViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('TO DO LIST'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Consumer<TodoViewModel>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: viewModel.todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                  child: Container(
                    width: 320.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.todoList[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ListCreate();
              },
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
