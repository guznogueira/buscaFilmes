class AppConstants {
  static const String omdbBaseUrl = 'https://www.omdbapi.com/';
  static const String omdbApiKey = '3465e26f';

  // Apenas para já buscar alguns filmes ao abrir o app
  // Pois a API não tem uma função que permita buscas sem ter um ID ou Nome
  static const genericTerms = [
    "love",
    "war",
    "dark",
    "life",
    "man",
    "star",
    "night",
    "death",
    "game",
    "city",
  ];
}
