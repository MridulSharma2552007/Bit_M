import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:just_audio/just_audio.dart';

class PlayerService {
  final YoutubeExplode _yt = YoutubeExplode();
  final AudioPlayer _player = AudioPlayer();

  // Stream to get playback state
  AudioPlayer get player => _player;

  Future<void> play(String videoId) async {
    try {
      // Get video manifest (contains audio and video stream info)
      final manifest = await _yt.videos.streamsClient.getManifest(videoId);

      // Pick the highest quality audio stream
      final audio = manifest.audioOnly.withHighestBitrate();

      // Play it using just_audio
      await _player.setUrl(audio.url.toString());
      await _player.play();
    } catch (e) {
      print('Error playing video: $e');
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _yt.close();
    _player.dispose();
  }
}
