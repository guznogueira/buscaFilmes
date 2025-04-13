import 'package:busca_filmes/application/movie/movie_bloc.dart';
import 'package:busca_filmes/data/datasources/omdb_service.dart';
import 'package:busca_filmes/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca Filmes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => MovieBloc(OmdbService()),
        child: const HomePage(),
      ),
    );
  }
}
