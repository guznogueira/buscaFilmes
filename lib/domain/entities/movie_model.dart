class MovieModel {
  final String title;
  final String year;
  final String imdbId;
  final String genre;
  final String poster;
  final String plot;

  MovieModel({
    this.title = '',
    this.year = '',
    this.imdbId = '',
    this.genre = '',
    this.poster = '',
    this.plot = '',
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      imdbId: json['imdbID'] ?? '',
      genre: json['Genre'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
    );
  }
}
