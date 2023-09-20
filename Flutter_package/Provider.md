```dart
//Multi Provider
MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ErrorController()),
        ChangeNotifierProvider(create: (context) => MajorController()),
        ChangeNotifierProvider(create: (context) => CommentController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(child: Choose()),
          );
        },
      ),
    );
```

```dart
//초반 설정
import 'package:provider/provider.dart';

ChangeNotifierProvider(
      create: (context) => ListController(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
```

```dart
//Provider
import 'package:flutter/material.dart';

class ListController extends ChangeNotifier {
  final List<String> _todolist = [];//

  List get todolist => _todolist;//_todolist에 넣어주는 변수 선언

  void add(String value) {
    print(value);
    _todolist.add(value);
    notifyListeners();//setState같은 애
  }
}
```

```dart
//사용방법(선언)
var listController = Provider.of<ListController>(context);

actions: [
 Padding(
  padding: EdgeInsets.only(right: 18.w),
  child: IconButton(
	  icon: const Icon(Icons.check),
    color: const Color(0xFF6BB16D),
    onPressed: () {
	    listcontroller.add(todaylist.text);//class명.함수명
      Navigator.pop(context);
     },
    ),
   ),
  ],
```

```dart
//사용방법 (보여주기)
var listController = Provider.of<ListController>(context);

ListView.builder(
	physics: const BouncingScrollPhysics(),
  itemCount: listController.todolist.length,
  itemBuilder: (context, index) {
	  return Card(
	    color: Colors.white,
      margin: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.w),
      child: Column(
	      children: [
	        Row(
	          mainAxisAlignment: MainAxisAlignment.start,
		        children: [
	            IconButton(
	              onPressed: () {},
                icon: const Icon(Icons.more_vert)),
                SizedBox(width: 20.w),
                Text(
	                listController.todolist[index],//class명.사용할 변수명
                  style: TextStyle(fontSize: 14.sp),
								),
							],
						),
					],
				),
			);
		},
	),
```