import 'package:busca_filmes/core/constants/app_constants.dart';
import 'package:busca_filmes/core/storage/movie_storage.dart';
import 'package:busca_filmes/domain/entities/movie_model.dart';
import 'package:flutter/material.dart';

import 'movie_grid.dart';

class RecentTab extends StatelessWidget {
  const RecentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<MovieModel>>(
        future: MovieStorage.getRecentMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(child: Text('Desculpe, ocorreu um erro'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum filme pesquisado'));
          }

          return MovieGrid(movies: snapshot.data!, tab: AppConstants.tabRecents);
        },
      ),
    );
  }
}
