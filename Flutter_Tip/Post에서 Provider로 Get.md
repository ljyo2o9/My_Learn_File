```dart
//provider
import 'package:flutter/material.dart';
import 'package:up/model/comment_id.dart';
import 'package:up/reply/reply.dart';

class CommentIdController extends ChangeNotifier {
  String _commentId = '오류';

  String get commentId => _commentId;

  void addCommentId(int id, String comment) async {
    final CommentID commentID = await postComment(id, comment);
    _commentId = commentID.id.toString();
    notifyListeners();
  }
}
```

```dart
//model
class CommentID {
  int? id;

  CommentID({this.id});

  CommentID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
```

```dart
//mainpage
Future delPost(id) async {
  final url = '$baseUrl/post/$id';

  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'accessToken');

  var response = await http.delete(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });

  if (response.statusCode != 204) {
    throw Exception(jsonDecode(utf8.decode(response.bodyBytes)));
  } else if (response.statusCode == 403) {
    print(token);
  }
}

//provider 실행하기 위한것
var commentIdController = Provider.of<CommentIdController>(context);

//provider addCommnetId실행
commentIdController.addCommentId(id,commentTextController.text);
```