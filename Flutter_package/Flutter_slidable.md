## flutter_slidable

```dart
import 'package:flutter_slidable/flutter_slidable.dart';

ListView.builder(
          itemCount: todoViewModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
              child: Slidable(//Slidable를 사용할 수 있게 해줌
                key: ValueKey(index),

								// 오른쪽으로 스크롤 왼쪽에 생성
								// endActionPane도 있음(얘는 왼쪽으로 스크롤 오른쪽에 생성)
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),// 스크롤 했을때 위젯이 나오는 모션
                  children: [
                    SlidableAction(// 스크롤시 나오는 위젯
                      onPressed: (context) async {
                        await viewModel.delList(viewModel.todoList[index].id);
                        await viewModel.getTodoList();
                      },
                      flex: 1,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Colors.red,
                      autoClose: false,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListModify(index: index),
                          ),
                        );
                      },
                      flex: 1,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Colors.blue,
                      autoClose: false,
                      icon: Icons.mode,
                      label: 'Modify',
                    ),
                  ],
                ),
                child: Container(// 스크롤 전에 보이는 위젯
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
```