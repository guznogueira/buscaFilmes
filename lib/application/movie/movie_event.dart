import 'package:busca_filmes/domain/entities/movie_model.dart';

abstract class MovieEvent {}

// Evento pesquisar um filme pelo nome
class SearchMovies extends MovieEvent {
  final String nameMovie;

  SearchMovies(this.nameMovie);
}

// Evento busca uma lista aleatoria de filmes
class LoadInitialMovies extends MovieEvent {}

// Evento busca um filme pelo id
class GetDetailsMovie extends MovieEvent {
  final MovieModel movie;

  GetDetailsMovie(this.movie);
}

// Evento recarrega lista de filmes da home
class RefreshListMovies extends MovieEvent {
  final List<MovieModel> listMovies;

  RefreshListMovies(this.listMovies);
}
