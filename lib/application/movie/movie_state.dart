import '../../../domain/entities/movie_model.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MoviesLoaded extends MovieState {
  final List<MovieModel> movies;

  MoviesLoaded(this.movies);
}

class MovieLoaded extends MovieState {
  final MovieModel movie;

  MovieLoaded(this.movie);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
