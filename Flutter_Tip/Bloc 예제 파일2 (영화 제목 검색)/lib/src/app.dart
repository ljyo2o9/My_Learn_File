import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movie_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 검색'),
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
                      const Divider(color: Colors.grey),
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
