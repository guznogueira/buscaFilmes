import 'dart:convert';

import 'package:busca_filmes/domain/entities/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieStorage {
  static const _key = 'recent_movies';

  // Salvar um novo filme
  static Future<void> saveRecentMovie(MovieModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> recentMovies = prefs.getStringList(_key) ?? [];

    // Serializa o filme
    final movieJson = jsonEncode({
      'title': movie.title,
      'year': movie.year,
      'imdbId': movie.imdbId,
      'poster': movie.poster,
    });

    // Remove duplicados (se já existir)
    recentMovies.removeWhere((m) {
      final map = jsonDecode(m);
      return map['imdbId'] == movie.imdbId;
    });

    // Insere no início
    recentMovies.insert(0, movieJson);

    // Mantém apenas os 5 primeiros
    if (recentMovies.length > 5) {
      recentMovies.removeLast();
    }

    await prefs.setStringList(_key, recentMovies);
  }

  // Recuperar a lista de filmes
  static Future<List<MovieModel>> getRecentMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> recentMovies = prefs.getStringList(_key) ?? [];

    return recentMovies.map((m) {
      final map = jsonDecode(m);
      return MovieModel(
        title: map['title'],
        year: map['year'],
        imdbId: map['imdbId'],
        poster: map['poster'],
      );
    }).toList();
  }
}
