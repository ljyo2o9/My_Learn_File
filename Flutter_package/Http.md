```dart
import 'package:http/http.dart' as http;
```

- Get
    
    ```dart
    import 'dart:convert';
    
    import 'package:http/http.dart' as http;
    import 'package:servermake/model.dart';
    
    Future<TestList> getList() async {
      var url = 'https://jsonplaceholder.typicode.com/albums';
      final response = await http.get(Uri.parse(url));
    
      if (response.statusCode == 200) {
        return TestList.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception('No Server Response');
      }
    }
    
      Future<TestList>? model;
    
      @override
      void initState() {
        super.initState();
        model = getList(); //getList함수를 호출하여 데이터를 가져와서 test 변수에 할당
      }
    
     FutureBuilder(
          future: model,
          builder: (context, snapshot) {
    	if(snapshot.hasData{return ;}
    	else if (snapshot.hasError) {return Text(snapshot.error.toString());}
    	else return const CircularProgressIndicator(); // 로딩 인디케이터 표시
    }
    ```
    
- Post
    
    ```dart
    import 'dart:convert';
    
    import 'package:flutter/material.dart';
    import 'package:postflutter/model.dart';
    import 'package:http/http.dart'  as http;
    
    Future postServer(String justText) async {
    	var response = await http.post(
        Uri.parse('http://192.168.1.76:8080/post'),
        headers: {'Content-Type': 'application/json'}, //필수
        body: jsonEncode({"justText": justText}),
      );
    
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    }
    
    late TextEditingController justText;
    
    @override
     void initState() {
       super.initState();
       justText = TextEditingController();
     }
    
    Container(
    	margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
    	child: TextField(
    		decoration: const InputDecoration(
    			labelText: 'justText',
    			border: OutlineInputBorder(
    				borderSide: BorderSide(color: Colors.black))),
    		controller: justText,
    	),
    ),
    
    MaterialButton(
    	child: const Text('Post Server'),
    	onPressed: () {
    		postServer(justText.text);
    	},
    )
    ```
    
- Delete
    
    ```dart
    import 'dart:convert';
    
    import 'package:flutter/material.dart';
    import 'package:postflutter/model.dart';
    import 'package:http/http.dart' as http;
    
    Future postServer(String justText) async {
    	var response = await http.post(
        Uri.parse('http://192.168.1.76:8080/post'),
        headers: {'Content-Type': 'application/json'}, //필수
        body: jsonEncode({"justText": justText}),
      );
    
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    }
    
    late TextEditingController justText;
    
    @override
     void initState() {
       super.initState();
       justText = TextEditingController();
     }
    
    Container(
    	margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
    	child: TextField(
    		decoration: const InputDecoration(
    			labelText: 'justText',
    			border: OutlineInputBorder(
    				borderSide: BorderSide(color: Colors.black))),
    		controller: justText,
    	),
    ),
    
    MaterialButton(
    	child: const Text('Post Server'),
    	onPressed: () {
    		postServer(justText.text);
    	},
    )
    ```