import 'package:flutter/material.dart';
import 'package:siyar_flex/screens/shared/video_link_screens.dart';
import 'package:siyar_flex/shared/movie_service.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.movie});
  final Movie movie;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie.title} '),
      ),
      body: Center(
        child: Column(
          children: [
            widget.movie.getBackdropUrl() != null
                ? Image.network(
                    widget.movie.getBackdropUrl(),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.overview,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rating: ${widget.movie.voteAverage.toStringAsFixed(1)}/10',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Release Date: ${widget.movie.releaseDate}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.black,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      Colors.white,
                    ),
                    //make the button full width
                    minimumSize: WidgetStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoLinkScreen(
                          movieId: widget.movie.id.toString(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Play'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//https://vavoo.to/web-vod/api/get?link=0kk5dq9LmtSgTShZWG_OUP5h11BCz8TzGf6b4k065vDh2TuY7jH4ujYrknQEIw71xosRiHGcU2tslJT0KeGwTg