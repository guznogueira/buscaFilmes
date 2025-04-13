import 'package:busca_filmes/application/movie/movie_event.dart';
import 'package:busca_filmes/application/movie/movie_state.dart';
import 'package:busca_filmes/domain/entities/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/movie/movie_bloc.dart';

class DetailsMovie extends StatefulWidget {
  final MovieModel movie;

  const DetailsMovie({super.key, required this.movie});

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  late MovieModel movie;

  _DetailsMovieState();

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
    context.read<MovieBloc>().add(GetDetailsMovie(movie));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieError) {
              return Center(child: Text('Erro: ${state.error}'));
            } else if (state is DetailsMovieLoaded) {
              final movie = state.movie;
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(movie!.title, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 12),

                      // Poster
                      SizedBox(
                        width: double.maxFinite,
                        height: 500,
                        child: Image.network(
                          movie.poster,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Ano e Gênero
                      Row(
                        children: [
                          Text('Ano: ${movie.year}'),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Gênero: ${movie.genre}', textAlign: TextAlign.right)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(movie.plot),
                    ],
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
