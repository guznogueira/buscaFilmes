import '../../../domain/entities/movie_model.dart';

class MovieState {
  final List<MovieModel> listMovies;
  final MovieModel? movie;
  final bool isLoading;
  final String? error;

  MovieState({
    required this.listMovies,
    this.movie,
    this.isLoading = false,
    this.error,
  });

  factory MovieState.initial() => MovieState(listMovies: []);

  MovieState copyWith({
    List<MovieModel>? listMovies,
    MovieModel? movie,
    bool? isLoading,
    String? error,
  }) {
    return MovieState(
      listMovies: listMovies ?? this.listMovies,
      movie: movie ?? this.movie,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Estado inicial
class MovieInitial extends MovieState {
  MovieInitial() : super(listMovies: []);
}

// Estado de carregando
class MovieLoading extends MovieState {
  MovieLoading() : super(listMovies: [], isLoading: true);
}

// Estado de carregado a lista de filmes
class MoviesLoaded extends MovieState {
  MoviesLoaded(List<MovieModel> listMovies) : super(listMovies: listMovies);
}

// Estado de carregado detalhes do filme
class DetailsMovieLoaded extends MovieState {
  DetailsMovieLoaded(MovieModel movie) : super(listMovies: [], movie: movie);
}

// Estado de erro
class MovieError extends MovieState {
  MovieError(String message) : super(listMovies: [], error: message);
}
