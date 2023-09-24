//Json to Dart
class Album {
  int? userId;
  int? id;
  String? title;

  Album({this.userId, this.id, this.title});

  // 생성자 까지 알잘딱 깔기

  //factory로 데이터 받기
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
