import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_widget_sample/src/bloc/sample_bloc.dart';

class BlocProviderPage extends StatelessWidget {
  const BlocProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBloc(),
      lazy: false,
      child: const SamplePage(),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Bloc Provider Sample'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          /// context.read<사용하려는 Bloc>().add(사용하려는 이벤트 (코드 보면 class로 되어있음));
          context.read<SampleBloc>().add(SampleEvent());
        },
      ),
    );
  }
}
