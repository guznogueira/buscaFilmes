import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/omdb_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/storage/movie_storage.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final OmdbService omdbService;

  MovieBloc(this.omdbService) : super(MovieInitial()) {
    on<LoadInitialMovies>(_onLoadInitialMovies);
    on<SearchMovies>(_onSearchMovies);
    on<GetMovie>(_onGetMovie);
  }

  // Busca uma lista aleatória de filmes
  Future<void> _onLoadInitialMovies(LoadInitialMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final random = Random();
      const genericTerms = AppConstants.genericTerms;
      final randomTerm = genericTerms[random.nextInt(genericTerms.length)];
      final movies = await omdbService.searchMovies(randomTerm);
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Busca uma lista de filmes pelo nome
  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await omdbService.searchMovies(event.query);

      if (movies.isNotEmpty) {
        await MovieStorage.saveRecentMovie(movies.first);
      }

      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Busca um filme pelo id
  Future<void> _onGetMovie(GetMovie event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movie = await omdbService.getMovie(event.query);

      emit(MovieLoaded(movie));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
