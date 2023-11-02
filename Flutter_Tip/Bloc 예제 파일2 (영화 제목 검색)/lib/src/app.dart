import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/src/cubit/bloc/movie_bloc.dart';

// import 'package:flutter_example/src/cubit/movie_cubit.dart';
// import 'package:rxdart/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화 검색'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              context.read<MovieBLoc>().add(SearchMovieEvent(value));
            },
          ),
          Expanded(
            child: BlocBuilder<MovieBLoc, List<String>>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(state[index]),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey),
                  itemCount: state.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
