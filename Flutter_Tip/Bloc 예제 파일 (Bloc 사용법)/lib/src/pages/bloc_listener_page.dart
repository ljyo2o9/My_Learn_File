import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_widget_sample/src/bloc/sample_bloc.dart';

class BlocListenerPage extends StatefulWidget {
  const BlocListenerPage({super.key});

  @override
  State<BlocListenerPage> createState() => _BlocListenerPageState();
}

class _BlocListenerPageState extends State<BlocListenerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBloc(),
      child: SamplePage(),
    );
  }
}

class SamplePage extends StatelessWidget {
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
    sampleBloc = context.read<SampleBloc>();
    return Scaffold(
      body: Center(
        child: BlocListener<SampleBloc, int>(
          /// listenWhen으로 listener을 통제함
          listenWhen: (previous, current) => current > 5,

          /// 얘도 listBuilder에서 실행시켜도 상관없지만 구분을 위한 목적임
          listener: (context, state) {
            _showMessage(context);
          },

          /// child이지만 BLocBuilder가 들어가 있어서 얘는 rebuild가 됨
          child: BlocBuilder<SampleBloc, int>(
              buildWhen: (previous, current) => current > 5,
              builder: (context, state) {
                return Text(
                  state.toString(),
                  style: const TextStyle(fontSize: 70),
                );
              }),
        ),
        // child: BlocListener<SampleBloc, int>(
        //   //
        //   /// listWhen으로 listener를 통제함
        //   listenWhen: (previous, current) => current > 5,
        //
        //   /// 얘도 그냥 실행
        //   listener: (context, state) {
        //     _showMessage(context);
        //   },
        //
        //   /// 여기서 선언해둔 Text는 초기값 0을 받고 그 이후로는 rebuild가 되지 않음
        //   /// 그러므로 0에서 더이상 숫자가 올라가지 않음
        //   child: Text(
        //     context.read<SampleBloc>().state.toString(),
        //     style: const TextStyle(fontSize: 70),
        //   ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SampleBloc>().add(AddSampleEvent());
        },
      ),
    );
  }
}
