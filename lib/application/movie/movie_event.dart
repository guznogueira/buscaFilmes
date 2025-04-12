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
