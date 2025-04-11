import 'package:busca_filmes/core/storage/movie_storage.dart';
import 'package:busca_filmes/domain/entities/movie_model.dart';
import 'package:busca_filmes/presentation/widgets/movie_grid.dart';
import 'package:flutter/material.dart';

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
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum filme pesquisado recentement'));
          }

          return MovieGrid(movies: snapshot.data!);
        },
      ),
    );
  }
}
