import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/src/app.dart';
import 'package:flutter_example/src/bloc/movie_bloc.dart';
import 'package:flutter_example/src/repository/movie_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => MovieRepository(),
        child: BlocProvider(
          create: (context) => MovieBLoc(context.read<MovieRepository>()),
          child: const App(),
        ),
      ),
    );
  }
}
