import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/omdb_service.dart';
import '../../core/constants/app_constants.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final OmdbService omdbService;

  MovieBloc(this.omdbService) : super(MovieInitial()) {
    on<LoadInitialMovies>(_onLoadInitialMovies);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onLoadInitialMovies(LoadInitialMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final random = Random();
      const genericTerms = AppConstants.genericTerms;
      final randomTerm = genericTerms[random.nextInt(genericTerms.length)];
      final movies = await omdbService.searchMovies(randomTerm);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await omdbService.searchMovies(event.query);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
