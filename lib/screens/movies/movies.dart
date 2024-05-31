import 'package:flutter/material.dart';
import 'package:siyar_flex/main.dart';
import 'package:siyar_flex/movie_service.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _movieService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainApp()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: _movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found.'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
                childAspectRatio: 0.7, // Aspect ratio for each grid item
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return GridTile(
                  child: Image.network(movie.getPosterUrl(), fit: BoxFit.cover),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(movie.title, textAlign: TextAlign.center),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
