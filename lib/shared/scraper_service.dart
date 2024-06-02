import 'package:http/http.dart' as http;
import 'dart:convert';

class ScraperService {
  Future<List<String>> fetchVideoLinks(String url, String movieId) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
        'accept-language': 'en-US,en;q=0.9,de;q=0.8',
        'api-key': 'YUnZZrvHRkoZxmDp0ZI4c1FJq',
        'content-type': 'application/json; charset=utf-8',
        'priority': 'u=1, i',
        'sec-ch-ua':
            '"Google Chrome";v="125", "Chromium";v="125", "Not.A/Brand";v="24"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'Referer': "https://vavoo.to/web-vod/item?id=movie.$movieId",
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data is List) {
        List<String> videoLinks =
            data.map((item) => item['url'] as String).toList();
        return videoLinks;
      } else {
        return ['No video links found'];
      }
    } else {
      throw Exception('Failed to load webpage');
    }
  }
}
