import 'dart:convert';
import 'package:bit_m/keys.dart';
import 'package:http/http.dart' as http;

class YouTubeService {
  final String apiKey = Keys.ytApiKey;

  Future<List<Map<String, dynamic>>> fetchVideoDetails(String query) async {
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> videos = [];
      for (var item in data['items']) {
        videos.add({
          'videoId': item['id']['videoId'],
          'title': item['snippet']['title'],
          'thumbnailUrl': item['snippet']['thumbnails']['high']['url'],
          'channelTitle': item['snippet']['channelTitle'],
        });
      }
      return videos;
    } else {
      throw Exception('Failed to load video details');
    }
  }
}
