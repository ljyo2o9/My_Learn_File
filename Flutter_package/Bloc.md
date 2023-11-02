## Bloc

### Bloc 선언방법

- 한개의 bloc
    
    ```dart
    // SampleSecondsBloc class에서 한개의 bloc만을 사용할때
    import 'package:bloc/bloc.dart';
    
    class SampleSecondsBloc extends Bloc<SampleSecondsEvent, int> {
      // super(0) 위에서 int형이라고 선언했으니 0으로 기본값 생성
      SampleSecondsBloc() : super(0) {
        print("init Sample Seconds Event Called");
        on<SampleSecondsEvent>((event, emit) {
          print('Sample Seconds Event Called');
        });
      }
    }
    
    class SampleSecondsEvent {}
    
    //////// 다른 페이지
    
    //////// 선언문
    BlocProvider(
      create: (context) => SampleSecondsBloc(),
      child: SamplePage(),
    ),
    
    //////// 사용할때
    ElevatedButton(
      onPressed: () {
        context.read<SampleBloc>().add(AddSampleEvent());
      },
      child: Text('-'),
    ),
    
    //출력
    //SampleSeconds Event Called (터미널)
    ```
    
- 여러개의 bloc ( on<Bloc>에 있는 Bloc을 상속 받을때
    
    ```dart
    // SampleBolc class에서 여러 개의 bloc을 사용할 때
    import 'package:bloc/bloc.dart';
    
    // Bloc<코드 안에 있는 on에서 사용할 bloc, return 될 데이터>
    class SampleBloc extends Bloc<SampleEvent, int> {
      SampleBloc() : super(0) {
        print('init Samplebloc');
        on<SampleEvent>((event, emit) {
          print('Sample Event Called');
        });
        on<AddSampleEvent>((event, emit) {
          emit(state + 1);
        });
      }
    }
    // 얘를 사용하겠다고 위에서 선언
    class SampleEvent {}
    // 제네릭에 여러개의 bloc이 들어갈 수 없으므로 SampleEvent를 extends함
    // 여기서 생기는 문제는 on<AddSampleEvent>를 했더라도 SampleEvent를 상속받아서
    // AddSampleEvent를 할 때 SampleEvent도 같이 출력됨
    class AddSampleEvent extends SampleEvent {}
    
    //////// 다른 페이지
    
    //////// 선언문
    BlocProvider(
      create: (context) => SampleBloc(),
      child: SamplePage(),
    ),
    
    //////// 사용할때
    children: [
      ElevatedButton(
        onPressed: () {
          // add(SampleEvent()) -> 출력
          // Sample Event Called (터미널)
          context.read<SampleBloc>().add(SampleEvent());
        },
        child: Text('+')
      ),
      const SizedBox(width: 15),
      ElevatedButton(
        onPressed: () {
          // add(AddSampleEvent()) -> 출력
          // Sample Event Called (터미널)
          // emit(state + 1) (화면) -> 
            // AddSampleEvent가 SampleEvent를 상속받았기 떄문에
            // emit(state+1)만 있더라도 Sample Evnet Called(터미널)이 작동함
          context.read<SampleBloc>().add(AddSampleEvent());
        },
        child: Text('-'),
      ),
    ],
    ```
    
- 여러개의 bloc ( on<Bloc>에 있는 Bloc이 아닌 추상 클래스를 상속
    
    ```dart
    import 'package:bloc/bloc.dart';
    
    // Bloc<AllSampleEvent, int>를 삽입
    // 하지만 밑 코드에는 on<AllSampleEvent>가 없음 왜일까?
    
    // 바로 AllSampleEvent는 다른 Bloc을 사용하기 위한 추상 클래스 이기 때문
    class SampleBloc extends Bloc<AllSampleEvent, int> {
      SampleBloc() : super(0) {
        print('init Samplebloc');
        on<SampleEvent>((event, emit) {
          print('Sample Event Called');
        });
        on<AddSampleEvent>((event, emit) {
          emit(state + 1);
        });
      }
    }
    // 얘가 추상 클래스
    abstract class AllSampleEvent {}
    
    // extends AllSampleEvent를 했으므로
    // 위에서 Bloc<SampleEvent, int>를 하지 않아도 상속을 받아 사용할 수 있음
    class SampleEvent extends AllSampleEvent {}
    
    // 더이상 SampleEvent를 상속 받지 않음
    // 그러므로 출력할때 on<SampleEvent>에 있는 것을 출력하지 않음
    class AddSampleEvent extends AllSampleEvent {}
    
    //////// 다른 페이지
    
    //////// 선언문
    BlocProvider(
      create: (context) => SampleBloc(),
      child: SamplePage(),
    ),
    
    //////// 사용할때
    children: [
      ElevatedButton(
        onPressed: () {
          // add(SampleEvent()) -> 출력
          // Sample Event Called (터미널)
          context.read<SampleBloc>().add(SampleEvent());
        },
        child: Text('+')
      ),
      const SizedBox(width: 15),
      ElevatedButton(
        onPressed: () {
          // add(AddSampleEvent()) -> 출력
          // emit(state + 1) (화면)
          context.read<SampleBloc>().add(AddSampleEvent());
        },
        child: Text('-'),
      ),
    ],
    ```
    
- bloc에서 여러개의 데이터 관리하기
    
    ```dart
    import 'package:bloc/bloc.dart';
    import 'package:equatable/equatable.dart';
    
    class BlocSelectorBloc extends Bloc<BlocSelectorEvent, BlocSelectorState> {
      // 위에서 BlocSelectorState로 선언했으니 super(const BlocSelectorState로 기본값 설정)
      // 참고로 기본값을 이대로 하는 것이 아닌 밑에 BlocSelectorState에 기본값이 적혀 있음
      BlocSelectorBloc() : super(const BlocSelectorState()) {
        on<ChangeStateEvent>((event, emit) {
          // 여기서 state는 BlocSelectorState이다.
          // 밑에 수식은 state.changeState를 !(not)해주고 그 값을 가져온다
          emit(state.clone(changeState: !state.changeState));
        });
        on<ValueEvent>((event, emit) {
          // 여기서도 state는 BlocSelectorState이다.
          // 밑에 수식도 마찬가지로 state.value를 ++해준후 그 값을 가져온다.
          emit(state.clone(value: state.value + 1));
        });
      }
    }
    
    abstract class BlocSelectorEvent {}
    
    class ChangeStateEvent extends BlocSelectorEvent {}
    
    class ValueEvent extends BlocSelectorEvent {}
    
    class BlocSelectorState extends Equatable {
      final bool changeState;
      final int value;
    
      const BlocSelectorState({this.changeState = false, this.value = 0});
    
      BlocSelectorState clone({bool? changeState, int? value}) {
        return BlocSelectorState(
          changeState: changeState ?? this.changeState,
          value: value ?? this.value,
        );
      }
    
      @override
      List<Object?> get props => [value, changeState];
    }
    ```
    

### Flutter Bloc 위젯 종류

- BlocProvider
    
    Bloc + Provider, 블럭을 제공하는 우젯
    
    ```dart
    return BlocProvider(
      create: (context) => SampleBloc(),
      // 이 Provider가 실행될때 바로 시작하도록 false(기본값 true)
      laze: false,
      child: SamplePage(),
    );
    ```
    
    특징
    
    - 지연생성 옵션(lazy)
    - 하위 계층 위젯들에서 접근 가능
    - Bloc 생성후 메모리 반환의 경우 자동으로 해준다.
- MultiBlocProvider
    
    BlocProvider 다중등록
    
    ```dart
    return NUltiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BlocA()),
        BlocProvider(create: (context) => BlocB()),
        BlocProvider(create: (context) => BlocC()),
      ],
      child: const ChildA(),
    );
    ```
    
- BlocBuilder
    
    BlocProvider로 생성된 bloc을 사용할때 쓰는 widget
    
    - bloc 옵션을 사용하지 않고 사용시 현 context로 부터 bloc을 찾아 변화 감지를 한다.
    - **bloc을 지정하는 케이스의 경우 특별한 케이스에서 사용하라고 권장한다.**
        
        *bloc 옵션 없이 사용
        
        ```dart
        child : BlocBuilder<SampleBloc, int>(
          builder: (context, state) {
            return Text(
              state.toString(),
              style: const TextStyle(fontSize: 70),
            );
          }
        ),
        ```
        
        *bloc 옵션 사용
        
        ```dart
        
        //이렇게 선언을 해줘야 bloc: <- 여기에 사용가능
        SampleBloc sampleBloc = context.read<SampleBloc>();
        
        BlocBuilder<SampleBloc, int>(
          // showDialog같은 bloc범위 밖에 있는 곳에 bloc을 쓸때 주입
          bloc: sampleBloc,
          builder: (context, state) {
            return Text(state.toString());
          }
        ),
        ```
        
    
    - buildWhen 옵션을 통해 필요한 조건일때만 변화를 줄 수 있다.
        
        ```dart
        BlocBuilder<SampleBloc, int>(
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
        ```
        
    
- RepositoryProvider, MultiRepositoryProvider
    
    Repository + Provider, Repository(저장소)를 제공하는 위젯입니다
    
    - 지연생성 옵션(lazy)을 통해 관리 할 수 있다
    - 저장소 데이터를 가공할 수 있는 데이터베이스 or 외부 api통신 등 관리할때 사용
    
    ```dart
    // 사용방법 (Repository)
    return RepositoryProvider(
      create: (context) => RepositorySample(),
      child: BlocProvider(
        create: (context) => SampleBlocDI(context.read<RepositorySample>()),
        child: SamplePage(),
      ),
    );
    // 사용방법 (MultiRepository)
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RepositorySample(),
        ),
        RepositoryProvider(
          create: (context) => RepositorySecondSample(),
        )
      ],
      child: BlocProvider(
        create: (context) => SampleBlocDIMulti(
          context.read<RepositorySample>(),
          context.read<RepositorySecondSample>(),
        ),
        child: SamplePage(),
      ),
    );
    
    //Repository 코드
    class RepositorySample {
      Future<int> load() async {
        //api 통신 로컬 데이터 베이스 접근 데이터를 받아온다
        return Future.value(55);
      }
    }
    
    //Repository2 코드
    class RepositorySecondSample {
      Future<int> load() async {
        return Future.value(22);
      }
    }
    
    // bloc 코드
    import 'package:bloc/bloc.dart';
    import 'package:flutter_bloc_widget_sample/src/repository/repository_sample.dart';
    import 'package:flutter_bloc_widget_sample/src/repository/repository_seconds_sample.dart';
    
    class SampleBlocDIMulti extends Bloc<SampleDiMultiEvent, int> {
      final RepositorySample _repositorySample;
      final RepositorySecondSample _repositorySecondSample;
      SampleBlocDIMulti(this._repositorySample, this._repositorySecondSample)
          : super(0) {
        on<SampleDiFirstEvent>((event, emit) async {
          var data = await _repositorySample.load();
          emit(data);
        });
        on<SampleDiSecondEvent>((event, emit) async {
          var data = await _repositorySecondSample.load();
          emit(data);
        });
      }
    }
    
    abstract class SampleDiMultiEvent {}
    
    class SampleDiFirstEvent extends SampleDiMultiEvent {}
    
    class SampleDiSecondEvent extends SampleDiMultiEvent {}
    ```
    
- BlocSelector
    
    Bloc의 사태중 필요한 부분만 선택적으로 필터링하여 변경에 도움을 주는 Widget
    
    ```dart
    BlocSelector<BlocSelectorBloc, BlocSelectorState, bool>(
      selector: (state) => state.changeState,
      builder: (context, state) {
        return Text(
          state.toString(),
          style: const TextStyle(fontSize: 70),
        );
      },
    ),
    
    //////// 주석처리한 전체 코드
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
                /// 밑 코드는 Selector를 굳이 사용하지 않아도 사용 가능한 코드이다.
                /// Selector는 코드를 찾아주는 역할을 해 코드를 이쁘게 하지 그 이상 그 이하도 아니다.
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
    ```
    
- BlocListener, MultiBlocListener
    
    상태 변화에 따른 이벤트만 처리가 필요할때 사용되는 Widget
    
    *child 위젯의 경우 rebuild가 발생되지 않는다.ㄹ
    
    ```dart
    child: BlocListener<SampleBloc, int>(
      listenWhen: (previous, current) => current > 5,
      listener: (context, state) {
        _showMessage(context);
      }
      child: Text(
        context.read<SampleBloc>().state.toString(),
        style: const TextStyle(fontSize: 70),
      ),
    ),
    ```
    
    사용되는 예)
    
    - 특정 상태가 변경되었을때 메세지 팝업을 띄워야 하는 상황
    - Bloc간 통신이 필요할때
    
    ```dart
    //전체 코드
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
              /// 하지만 BlocConsumer가 있어 굳이 권장은 하지 않음
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
    ```
    
- BlocConsumer
    
    BlocBuilder와 BlocListener를 합쳐 놓은 위젯
    
    - 이벤트도 처리하면서 동시에 화면도 변경을 해줘야 할때 사용
    - buildWhen과 listenWhen조건을 통해 적절한 때에만 변경 및 이벤트 처리를 할 수 있다.