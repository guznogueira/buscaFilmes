import 'package:busca_filmes/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/movie_model.dart';

class OmdbService {
  final Dio _dio = Dio();
  final String _baseUrl = AppConstants.omdbBaseUrl;
  final String _apiKey = AppConstants.omdbApiKey;

  // Busca filmes pelo nome
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {'s': query, 'apikey': _apiKey});

      if (response.statusCode == 200) {
        final List list = response.data['Search'];
        return list.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar filmes');
      }
    } catch (e) {
      print('Dio Error: $e');
      return [];
    }
  }

  // Busca um filme pelo id
  Future<MovieModel> getDetailsMovie(String query) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {'i': query, 'apikey': _apiKey});

      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao buscar o filme');
      }
    } catch (e) {
      print('Dio Error: $e');
      rethrow;
    }
  }
}
