import 'package:flutter/material.dart';
import 'package:siyar_flex/shared/scraper_service.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoLinkScreen extends StatefulWidget {
  const VideoLinkScreen({super.key, required this.movieId});
  final String movieId;

  @override
  _VideoLinkScreenState createState() => _VideoLinkScreenState();
}

class _VideoLinkScreenState extends State<VideoLinkScreen> {
  final ScraperService scraperService = ScraperService();
  Future<List<String>>? futureVideoLinks;

  @override
  void initState() {
    super.initState();
    futureVideoLinks = scraperService.fetchVideoLinks(
        "https://vavoo.to/web-vod/api/links?id=movie.${widget.movieId}",
        widget.movieId);
  }

  void _launchURL(String url) async {
    final completeUrl = 'https://vavoo.to/web-vod/api/get?link=$url';
    if (await canLaunch(completeUrl)) {
      await launch(completeUrl);
    } else {
      throw 'Could not launch $completeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Links Scraper'),
      ),
      body: FutureBuilder<List<String>>(
        future: futureVideoLinks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No video links found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final url = snapshot.data![index];
                return ListTile(
                  title: Text('Video Link ${index + 1}'),
                  subtitle: Text(url),
                  onTap: () => _launchURL(url),
                );
              },
            );
          }
        },
      ),
    );
  }
}
