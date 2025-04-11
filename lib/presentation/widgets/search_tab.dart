import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/movie/movie_bloc.dart';
import '../../application/movie/movie_event.dart';
import '../../application/movie/movie_state.dart';
import '../../core/storage/movie_storage.dart';
import 'movie_grid.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        // Campo de busca
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Nome do filme...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final query = searchController.text.trim();
                  if (query.isNotEmpty) {
                    context.read<MovieBloc>().add(SearchMovies(query));
                  }
                },
                child: const Text('Buscar'),
              )
            ],
          ),
        ),

        // Resultado da busca
        Expanded(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoaded) {
                return MovieGrid(movies: state.movies);
              } else if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieError) {
                return Center(child: Text('Erro: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
