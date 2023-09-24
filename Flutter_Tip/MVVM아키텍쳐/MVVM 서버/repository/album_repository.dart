// 서버에서 온 데이터를 가져오기

import 'package:mvvm/dataSource/data_source.dart';
import 'package:mvvm/model/album.dart';

class AlbumRepository {
  // _dataSource = DataSource() = 클래스
  final DataSource _dataSource = DataSource();

  Future<List<Album>> getAlbumList() {
    // _dataSource = response.data.map<Album>((json) => Album.fromJson(json)).toList();
    return _dataSource.getAlbumList();
  }
}
