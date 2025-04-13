import '../../../domain/entities/movie_model.dart';

abstract class MovieState {}

// Estado inicial
class MovieInitial extends MovieState {}

// Estado de carregando
class MovieLoading extends MovieState {}

// Estado de carregado a lista de filmes
class MoviesLoaded extends MovieState {
  final List<MovieModel> listMovies;

  MoviesLoaded(this.listMovies);
}

// Estado de carregado detalhes do filme
class DetailsMovieLoaded extends MovieState {
  final MovieModel movie;

  DetailsMovieLoaded(this.movie);
}

// Estado de erro
class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
