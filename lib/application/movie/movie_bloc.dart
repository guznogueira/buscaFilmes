import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/omdb_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/storage/movie_storage.dart';
import '../../domain/entities/movie_model.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final OmdbService omdbService;

  List<MovieModel> cachedMovies = [];

  MovieBloc(this.omdbService) : super(MovieInitial()) {
    on<LoadInitialMovies>(_onLoadInitialMovies);
    on<SearchMovies>(_onSearchMovies);
    on<GetDetailsMovie>(_onGetDetailsMovie);
    on<RefreshListMovies>(_onRefreshListMovies);
  }

  // Busca uma lista aleatória de filmes
  Future<void> _onLoadInitialMovies(LoadInitialMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final random = Random();
      const genericTerms = AppConstants.genericTerms;
      final randomTerm = genericTerms[random.nextInt(genericTerms.length)];
      final movies = await omdbService.searchMovies(randomTerm);
      cachedMovies = movies;
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Busca uma lista de filmes pelo nome
  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await omdbService.searchMovies(event.nameMovie);
      cachedMovies = movies;
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Busca um filme pelo id, para ter os detalhes
  Future<void> _onGetDetailsMovie(GetDetailsMovie event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      MovieModel movie;

      // Caso esteja pequisando o filme pela primeira vez, ira buscar mais informações e salvar no preferences
      if (event.movie.plot.isEmpty) {
        movie = await omdbService.getDetailsMovie(event.movie.imdbId);
        await MovieStorage.saveRecentMovie(movie);
      }
      // Caso ja tenha pesquisado o filme, as informações estarão no preferences
      else {
        movie = event.movie;
      }

      emit(DetailsMovieLoaded(movie));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Recarrega os filmes ao voltar para Home
  Future<void> _onRefreshListMovies(RefreshListMovies event, Emitter<MovieState> emit) async {
    try {
      List<MovieModel> movies = cachedMovies;
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
