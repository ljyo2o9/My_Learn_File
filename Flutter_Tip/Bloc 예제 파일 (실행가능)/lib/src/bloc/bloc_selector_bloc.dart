import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BlocSelectorBloc extends Bloc<BlocSelectorEvent, BlocSelectorState> {
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
