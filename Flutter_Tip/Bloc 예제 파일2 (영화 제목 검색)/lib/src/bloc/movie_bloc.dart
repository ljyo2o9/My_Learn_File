import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/src/repository/movie_repository.dart';

//
/// 이친구가 밑에있는 transformer에 있는 조건식을 할 수 있도록 도움
import 'package:rxdart/rxdart.dart';

class MovieBLoc extends Bloc<SearchMovieEvent, List<String>> {
  final MovieRepository _movieRepository;

  MovieBLoc(this._movieRepository) : super([]) {
    on<SearchMovieEvent>(
      (event, emit) async {
        var result = await _movieRepository.search(event.key);
        emit(result);
      },
      //
      /// onChange가 일어난 후에 1초가 지났을떄 위에 있는 on을 사용할 수 있도록 만듬
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 1000))
          .flatMap(mapper),
    );
  }

  // Bloc에서만 사용 가능한 함수로 print를 찍어보면 과정을 보여줌
  // onTransition(Transition<과정을 원하는 Bloc, 그 블록의 자료형>> transition)
  @override
  void onTransition(Transition<SearchMovieEvent, List<String>> transition) {
    super.onTransition(transition);
    //print(transition);
  }
}

class SearchMovieEvent extends Equatable {
  final String key;

  const SearchMovieEvent(this.key);

  @override
  List<Object?> get props => [];
}
