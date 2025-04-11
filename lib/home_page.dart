import 'package:busca_filmes/details_movie.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nome do filme...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Buscar'),
              )
            ],
          ),
        ),

        //Grid de filmes
        Expanded(
            child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(left: 8, right: 8),
          child: GridView.builder(
            itemCount: listMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final item = listMovies[index];
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
        )),
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
