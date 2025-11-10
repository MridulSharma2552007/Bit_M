import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:just_audio/just_audio.dart';
// optional if using background playback

class PlayerService {
  final YoutubeExplode _yt = YoutubeExplode();
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String videoId) async {
    try {
      print("🎬 Fetching manifest for $videoId...");
      final manifest = await _yt.videos.streamsClient.getManifest(videoId);

      final audio = manifest.audioOnly.withHighestBitrate();

      final url = audio.url.toString();
      print("🎧 Streaming from: $url");

      // ✅ Add user-agent header so YouTube accepts the request
      final headers = {
        "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.117 Safari/537.36",
      };

      final source = AudioSource.uri(Uri.parse(url), headers: headers);

      await _player.setAudioSource(source);
      await _player.play();
    } catch (e, st) {
      print("❌ Error playing video: $e");
      print(st);
    }
  }

  Future<void> stop() async => await _player.stop();

  void dispose() {
    _yt.close();
    _player.dispose();
  }
}
