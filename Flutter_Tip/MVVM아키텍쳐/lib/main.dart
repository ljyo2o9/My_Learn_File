// 알잘딱
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvvm/viewModel/album_view_model.dart';
import 'package:mvvm/View/album_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlbumViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AlbumView(),
      ),
    );
  }
}
