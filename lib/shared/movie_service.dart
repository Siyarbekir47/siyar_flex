import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = '';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class Movie {
  final String title;
  final String posterPath;
  final int id;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  Movie(
      {required this.title,
      required this.posterPath,
      required this.id,
      required this.backdropPath,
      required this.overview,
      required this.releaseDate,
      required this.voteAverage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      id: json['id'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  String getPosterUrl() {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String getBackdropUrl() {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  void play() {
    // Add code to play the movie
  }
}
