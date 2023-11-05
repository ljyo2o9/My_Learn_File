## **youtube_explode_dart**

Youtube Url만 있으면 그 영상의 정보를 볼 수 있음

```dart
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<void> main() async {
  var yt = YoutubeExplode();
  var vidio = await yt.videos.get("https://www.youtube.com/watch?v=fRh_vgS2dFE");

  print("Title: ${vidio.title}"); // 제목이 나옴
  print("author: ${vidio.author}"); // 영상을 올린 사람의 이름
}
```