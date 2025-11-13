import 'package:bit_m/keys.dart';
import 'package:just_audio/just_audio.dart';

class PlayerService {
  final AudioPlayer player = AudioPlayer();

  Future<void> play(String videoId) async {
    try {
      final url = '${Keys.NodeServer}$videoId';
      await player.setUrl(url);
      await player.play();
    } catch (e) {
      print("❌ Audio error: $e");
    }
  }

  Future<void> pause() async => await player.pause();
  Future<void> resume() async => await player.play();

  Future<void> seek(Duration position) async => await player.seek(position);

  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;

  void dispose() => player.dispose();
}
