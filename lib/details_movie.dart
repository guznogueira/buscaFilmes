import 'package:flutter/material.dart';

class DetailsMovie extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String date;
  final String genre;
  final String summary;

  const DetailsMovie({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.genre,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        title: const Text('Detalhes', style: TextStyle(color: Colors.white),),
        leading: const BackButton(),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),

      //Body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: Image.network(imageUrl),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text('Data: $date', style: Theme.of(context).textTheme.bodyMedium),
                ),
                Expanded(
                  child: Text('Gênero: $genre', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.right),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
