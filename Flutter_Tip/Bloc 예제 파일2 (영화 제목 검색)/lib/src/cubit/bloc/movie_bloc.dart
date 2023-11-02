import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/movie_repository.dart';

class MovieBLoc extends Bloc<SearchMovieEvent, List<String>> {
  MovieRepository _movieRepository;

  MovieBLoc(this._movieRepository) : super([]) {
    on<SearchMovieEvent>(
      (event, emit) async {
        var result = await _movieRepository.search(event.key);
        emit(result);
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 1000))
          .flatMap(mapper),
    );
  }

  @override
  void onTransition(Transition<SearchMovieEvent, List<String>> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

class SearchMovieEvent extends Equatable {
  final String key;

  const SearchMovieEvent(this.key);

  @override
  List<Object?> get props => [];
}
