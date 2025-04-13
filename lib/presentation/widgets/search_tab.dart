import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../application/movie/movie_bloc.dart';
import '../../application/movie/movie_event.dart';
import '../../application/movie/movie_state.dart';
import '../details_movie.dart';
import 'movie_grid.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<MovieBloc>().add(LoadInitialMovies());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              if (state is MoviesLoaded) {
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
