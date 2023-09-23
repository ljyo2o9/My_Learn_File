| View | 사용자에게 보여지는 영역 |
| --- | --- |
| ViewModel | View의 상태를 관리하고 View의 비즈니스 로직을 담당 |
| Repository | 데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근 |
| DataSource | 데이터를 가져오는 영역 |
| Model | 데이터 설계 |

이것을 바탕으로 아키텍쳐를 적용해보자

1. 다음처럼 폴더와 파일을 구성해 준다.
    
    <img width="453" alt="스크린샷 2023-09-20 오후 2 26 10" src="https://github.com/ljyo2o9/My_Learn_File/assets/126755727/bd44b6c8-84ea-4726-a28c-c844445b4c3f">
    
2. Model을 작성 (album.dart)
    
    ```dart
    // Json to Dart
    class Album {
    	int? userId;
    	int? id;
    	String? title;
    	Album({this.userId, this.id, this.title});
    	factory Album.fromJson(Map<String, dynamic> json) {
    		return Album(userId: json['userId'], id: json['id'], title: json['title']);
      }
    }
    ```
    
3. DataSource를 작성합니다. (dataSource.dart)
    
    원래는 localDataSource와 remoteDataSource를 나누는 것이 일반적이다.
    
    **localDataSource = Local에 있는 데이터를 가져오는 로직**
    
    **remoteDataSource = 서버에서 데이터를 가져오는 로직**
    
    ```dart
    // Http or Dio
    import 'dart:convert';
    import 'package:http/http.dart' as http;
    import '../model/album.dart';
    
    class DataSource {
      Future<List<Album>> getAlbumList() async {
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
        return jsonDecode(response.body)
            .map<Album>((json) => Album.fromJson(json))
            .toList();
      }
    }
    ```
    
4. Repository를 작성합니다. (albumRepository.dart)
    
    ```dart
    // 서버에서 온 데이터를 가져오기
    import '../dataSource/dataSource.dart';
    import '../model/album.dart';
    
    class AlbumRepository {
      final DataSource _dataSource = DataSource();
    
      Future<List<Album>> getAlbumList() {
        return _dataSource.getAlbumList();
      }
    }
    ```
    
5. ViewModel를 작성합니다. (albumViewModel.dart)
    
    ```dart
    // Provider로 Repository에 있는 데이터를 가져온다
    import 'package:flutter/material.dart';
    import '../model/album.dart';
    import '../repository/albumRepository.dart';
    
    class AlbumViewModel with ChangeNotifier {
      late final AlbumRepository _albumRepository;
      List<Album> _albumList = List.empty(growable: true);
      List<Album> get albumList => _albumList;
    
      AlbumViewModel() {
        _albumRepository = AlbumRepository();
        _getAlbumList();
      }
    
      Future<void> _getAlbumList() async {
        _albumList = await _albumRepository.getAlbumList();
        notifyListeners();
      }
    }
    ```
    
6. View를 작성합니다. (albumView.dart)
    
    ```dart
    // Provier를 통해 ViewModel에 있는 데이터를 가져온다
    import "package:flutter/material.dart";
    import "package:provider/provider.dart";
    import "package:provider_project/viewModel/albumViewModel.dart";
    
    import "../model/album.dart";
    
    class AlbumView extends StatefulWidget {
      const AlbumView({super.key});
    
      @override
      State<AlbumView> createState() => _AlbumViewState();
    }
    
    class _AlbumViewState extends State<AlbumView> {
      late List<Album> albumList;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("MVVM 실습"),
          ),
          body: Consumer<AlbumViewModel>(
            builder: (context, provider, child) {
              albumList = provider.albumList;
              return ListView.builder(
                itemCount: albumList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "${albumList[index].id}: ${albumList[index].title}",
                    ),
                  );
                },
              );
            },
          ),
        );
      }
    }
    ```
    
7. main.dart를 수정합니다. (Provider때문)
    
    ```dart
    // 알잘딱
    import 'package:flutter/material.dart';
    import 'package:provider/provider.dart';
    import 'package:provider_project/viewModel/albumViewModel.dart';
    import 'package:provider_project/view/albumView.dart';
    
    void main() {
      runApp(const MyApp());
    }
    
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: ChangeNotifierProvider<AlbumViewModel>(
            create: (context) => AlbumViewModel(),
            child: const AlbumView(),
          ),
        );
      }
    }
    ```