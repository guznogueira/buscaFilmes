import 'package:busca_filmes/core/constants/app_constants.dart';
import 'package:busca_filmes/presentation/widgets/recent_tab.dart';
import 'package:busca_filmes/presentation/widgets/search_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/movie/movie_bloc.dart';
import '../application/movie/movie_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final genericTerms = AppConstants.genericTerms;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadInitialMovies());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  // Controle da troca de abas
  void _onTabChanged() {
    if (_tabController.index == AppConstants.tabSearch) {
      context.read<MovieBloc>().add(RefreshListMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catálogo de Filmes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Buscar'),
            Tab(text: 'Recentes'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SearchTab(),
          RecentTab(),
        ],
      ),
    );
  }
}
