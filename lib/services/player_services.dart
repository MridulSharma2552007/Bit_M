import 'package:just_audio/just_audio.dart';

class PlayerService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String videoId) async {
    try {
      // your Node server address (replace with your PC’s IP)
      final url = 'http://10.181.154.110:3000/stream?id=$videoId';

      print('🎧 Playing from: $url');

      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      print('❌ Error playing: $e');
    }
  }

  Future<void> stop() async => await _player.stop();

  void dispose() => _player.dispose();
}