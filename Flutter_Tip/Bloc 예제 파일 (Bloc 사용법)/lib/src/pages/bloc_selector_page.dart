import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_widget_sample/src/bloc/bloc_selector_bloc.dart';

class BlocSelectorPage extends StatefulWidget {
  const BlocSelectorPage({super.key});

  @override
  State<BlocSelectorPage> createState() => _BlocSelectorPageState();
}

class _BlocSelectorPageState extends State<BlocSelectorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocSelectorBloc(),
      child: SamplePage(),
    );
  }
}

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<BlocSelectorBloc, BlocSelectorState, bool>(
              /// 여기서 말하는 state.changeState에서 state는 BlocSelectorState이고
              selector: (state) => state.changeState,
              //
              /// 여기서 말하는 state는 위에서 선언한 state.changeState
              /// 즉, BlocSelectorState 안에 있는 changeState 값이다.
              builder: (context, state) {
                print('selector builder');
                return Icon(
                  Icons.favorite,
                  color: state ? Colors.red : Colors.grey,
                  size: 50,
                );
              },
            ),
            // BlocBuilder<BlocSelectorBloc, BlocSelectorState>(
            //   builder: (context, state) {
            //     return Icon(
            //       Icons.favorite,
            //       color: state.changeState ? Colors.red : Colors.grey,
            //       size: 50,
            //     );
            //   },
            // ),
            BlocBuilder<BlocSelectorBloc, BlocSelectorState>(
              /// BlocSelectorState.changeState가 참일때
              /// builder를 build해라
              buildWhen: (previous, current) => current.changeState,
              builder: (context, state) {
                print('bloc builder');
                return Text(
                  state.value.toString(),
                  style: const TextStyle(fontSize: 70),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<BlocSelectorBloc>().add(ChangeStateEvent());
                    },
                    child: Text('상태변경')),
                const SizedBox(width: 15),
                ElevatedButton(
                    onPressed: () {
                      context.read<BlocSelectorBloc>().add(ValueEvent());
                    },
                    child: Text('더하기')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
