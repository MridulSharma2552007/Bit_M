import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bit_m/keys.dart';

class YouTubeService {
  final String apiKey = Keys.ytApiKey;

  // ---- SEARCH ----
  Future<List<Map<String, dynamic>>> fetchVideoDetails(String query) async {
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Map<String, dynamic>> videos = [];

      for (var item in data['items']) {
        final videoId = item['id']['videoId'];

        // fetch duration
        final duration = await fetchVideoDuration(videoId);

        videos.add({
          'videoId': videoId,
          'title': item['snippet']['title'],
          'thumbnailUrl': item['snippet']['thumbnails']['high']['url'],
          'channelTitle': item['snippet']['channelTitle'],
          'duration': parseDuration(duration),
        });
      }

      return videos;
    } else {
      throw Exception('Failed to load video details');
    }
  }

  // ---- GET VIDEO DURATION ----
  Future<String> fetchVideoDuration(String videoId) async {
    final url =
        'https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=$videoId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final duration = data["items"][0]["contentDetails"]["duration"];
      return duration;
    } else {
      return "Unknown";
    }
  }

  String parseDuration(String iso) {
    final regExp = RegExp(r'PT(\d+H)?(\d+M)?(\d+S)?');
    final match = regExp.firstMatch(iso);

    final hours =
        int.tryParse((match?.group(1) ?? '0H').replaceAll('H', '')) ?? 0;
    final minutes =
        int.tryParse((match?.group(2) ?? '0M').replaceAll('M', '')) ?? 0;
    final seconds =
        int.tryParse((match?.group(3) ?? '0S').replaceAll('S', '')) ?? 0;

    final totalSeconds = hours * 3600 + minutes * 60 + seconds;

    final mm = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final ss = (totalSeconds % 60).toString().padLeft(2, '0');

    return "$mm:$ss";
  }
}
