// Http or Dio
import 'package:dio/dio.dart';
import 'package:mvvm/model/album.dart';

class DataSource {
  final String url = 'https://jsonplaceholder.typicode.com/albums';

  Future<List<Album>> getAlbumList() async {
    Dio dio = Dio();

    final response = await dio.get(url);
    return response.data.map<Album>((json) => Album.fromJson(json)).toList();
    // 모델 통해서 불러올 때 방법은
    // .map<ModelClass명>((json) => ModelClass명.fromJson(json)).toList();
  }
}
