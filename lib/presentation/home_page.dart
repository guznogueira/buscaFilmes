import 'package:busca_filmes/core/constants/app_constants.dart';
import 'package:busca_filmes/presentation/widgets/recent_tab.dart';
import 'package:busca_filmes/presentation/widgets/search_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final genericTerms = AppConstants.genericTerms;

  @override
  void initState() {
    super.initState();
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
        body: const TabBarView(
          children: [
            SearchTab(),
            RecentTab(),
          ],
        ),
      ),
    );
  }
}
