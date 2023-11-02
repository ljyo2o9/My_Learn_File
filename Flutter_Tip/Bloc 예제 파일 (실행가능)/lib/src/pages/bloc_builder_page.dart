import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_widget_sample/src/bloc/sample_bloc.dart';

class BlocBuilderPage extends StatefulWidget {
  const BlocBuilderPage({super.key});

  @override
  State<BlocBuilderPage> createState() => _BlocBuilderPageState();
}

class _BlocBuilderPageState extends State<BlocBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //
      /// 여기서 등록한 Provider(Bloc)이여야 사용 가능
      create: (context) => SampleBloc(),
      lazy: false,
      child: SamplePage(),
    );
  }
}

class SamplePage extends StatelessWidget {
  //bloc을 등록해야 사용이 가능한 케이스
  late SampleBloc sampleBloc;


  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('Title'),
          content: BlocBuilder<SampleBloc, int>(
            bloc: sampleBloc,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          actions: [
            ElevatedButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 위에 있는 showDialog에 주입하기 위해 선언
    sampleBloc = context.read<SampleBloc>();
    return Scaffold(
      body: Center(
        //
        /// < 어떤 블록 인지, state의 제네릭 >
        child: BlocBuilder<SampleBloc, int>(
          //
          /// 여기 있는 조건일때 밑에 builder를 실행한다.
          buildWhen: (previous, current) {
            return current > 5;
          },
          builder: (context, state) {
            return Text(
              'index : $state',
              style: const TextStyle(fontSize: 70),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SampleBloc>().add(AddSampleEvent());
          _showMessage(context);
        },
      ),
    );
  }
}
