import 'package:busca_filmes/domain/entities/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../details_movie.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsMovie(
              title: movie.title,
              imageUrl: movie.poster,
              date: movie.year,
              genre: movie.type,
              summary: 'Sem sinopse disponível',
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              movie.poster,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image));
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            movie.year,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
