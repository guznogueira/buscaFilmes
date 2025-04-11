import 'package:busca_filmes/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie_model.dart';
import '../details_movie.dart';

class MovieGrid extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie);
      },
    );
  }
}