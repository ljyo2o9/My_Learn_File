// Provier를 통해 ViewModel에 있는 데이터를 가져온다
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:mvvm/viewModel/album_view_model.dart";

import 'package:mvvm/model/album.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM 실습"),
      ),
      // Consumer는 그냥 Provider사용하는 것보다 더 효율성 있게 만들어줌
      body: Consumer<AlbumViewModel>(
        builder: (context, provider, child) {
          // albumList = AlbumViewModel에 있는 값을 불러오는 애
          // 편하게 snapshot이라고 생각하면 편함
          List<Album> albumList = provider.albumList;

          return ListView.builder(
            itemCount: albumList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  // 이런식으로 사용하면 됨
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
