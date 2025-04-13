import 'package:busca_filmes/domain/entities/movie_model.dart';

abstract class MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies(this.query);
}

class LoadInitialMovies extends MovieEvent {}

class GetMovie extends MovieEvent {
  final String query;

  GetMovie(this.query);
}

class RefreshMovies extends MovieEvent {
  final List<MovieModel> movies;

  RefreshMovies(this.movies);
}
