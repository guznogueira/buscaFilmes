import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/movie/movie_bloc.dart';
import '../../application/movie/movie_event.dart';
import '../../application/movie/movie_state.dart';
import 'movie_grid.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  bool showClearIcon = false;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadInitialMovies());

    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    // Controle para mostrar ou não o botão para limpar campo de texto
    searchController.addListener(() {
      setState(() {
        showClearIcon = searchController.text.isNotEmpty;
      });
    });

    // Remove o foco do campo de texto ao abrir a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.unfocus();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
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
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                      hintText: 'Nome do filme...',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      suffixIcon: showClearIcon
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                              },
                              icon: const Icon(Icons.clear))
                          : null),
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
                return MovieGrid(movies: state.listMovies);
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
