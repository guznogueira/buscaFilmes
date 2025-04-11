import 'dart:math';

import 'package:busca_filmes/application/movie/movie_state.dart';
import 'package:busca_filmes/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/movie/movie_bloc.dart';
import '../application/movie/movie_event.dart';
import '../data/datasources/omdb_service.dart';
import 'details_movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final genericTerms = AppConstants.genericTerms;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> listMovies = List.generate(
    15,
    (index) => {
      'title': 'Titulo $index',
      'imageUrl': 'https://via.placeholder.com/150x220',
      'date': '2025-04-10',
      'genre': 'Genre $index',
      'summary': 'Summary $index'
    },
  );

  List<Map<String, String>> recentSearches = List.generate(
    5,
    (index) => {
      'title': 'Titulo $index',
      'imageUrl': 'https://via.placeholder.com/150x220',
      'date': '2025-04-10',
      'genre': 'Genre $index',
      'summary': 'Summary $index'
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Catálogo de Filmes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buscar'),
              Tab(text: 'Recentes'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: TabBarView(
          children: [
            _buildSearchTab(),
            _buildRecentTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
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
                  controller: _searchController,
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
                  final query = _searchController.text.trim();
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
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                final movies = state.movies;

                if (movies.isEmpty) {
                  return const Center(child: Text("Nenhum filme encontrado."));
                }

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
                  },
                );
              } else if (state is MovieError) {
                return Center(child: Text('Erro: ${state.message}'));
              } else {
                return const Center(child: Text("Busque um filme para começar."));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTab() {
    return Expanded(
        child: Container(
      color: Colors.white,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: GridView.builder(
        itemCount: recentSearches.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final item = recentSearches[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailsMovie(
                            title: item['title']!,
                            imageUrl: item['imageUrl']!,
                            date: item['date']!,
                            genre: item['genre']!,
                            summary: item['summary']!,
                          )));
            },
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    item['imageUrl']!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item['date']!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
