import 'package:busca_filmes/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/movie/movie_bloc.dart';
import '../../application/movie/movie_event.dart';
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
        return MovieCard(
          movie,
          (movie) => _navigatorDetails(movie, context),
        );
      },
    );
  }

  // Função ir para tela de detalhes, e recarregar a lista ao voltar
  Future<void> _navigatorDetails(MovieModel movie, BuildContext context) async {
    final bloc = context.read<MovieBloc>();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider<MovieBloc>.value(
          value: bloc,
          child: DetailsMovie(movie: movie),
        ),
      ),
    );

    bloc.add(RefreshListMovies(movies));
  }
}
