// Provider로 Repository에 있는 데이터를 가져온다
import 'package:flutter/material.dart';

import 'package:mvvm/model/album.dart';
import 'package:mvvm/repository/album_repository.dart';

class AlbumViewModel with ChangeNotifier {
  final AlbumRepository _albumRepository = AlbumRepository();

  //List.empty(growable: true) = 그냥 알잘딱 늘어 나는 빈 리스트 생성
  List<Album> _albumList = List.empty(growable: true);

  List<Album> get albumList => _albumList;

  AlbumViewModel() {
    _getAlbumList();
  }

  Future<void> _getAlbumList() async {
    _albumList = await _albumRepository.getAlbumList();
    notifyListeners();
  }
}
