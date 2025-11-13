import 'package:bit_m/services/player_services.dart';
import 'package:flutter/material.dart';

class Fullplayer extends StatefulWidget {
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String duration;
  final PlayerService player; // 👈 add this

  const Fullplayer({
    super.key,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.duration,
    required this.player,
  });

  @override
  State<Fullplayer> createState() => _FullplayerState();
}

class _FullplayerState extends State<Fullplayer> {
  double _currentSliderValue = 0;
  double _maxSliderValue = 1;

  @override
  void initState() {
    super.initState();

    /// listen to duration update
    widget.player.durationStream.listen((d) {
      if (d != null) {
        setState(() => _maxSliderValue = d.inSeconds.toDouble());
      }
    });

    /// listen to current position
    widget.player.positionStream.listen((p) {
      setState(() => _currentSliderValue = p.inSeconds.toDouble());
    });
  }

  String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 25),

          /// ARTWORK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                widget.thumbnailUrl,
                height: 310,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 40),

          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.artist,
            style: const TextStyle(color: Colors.white70, fontSize: 17),
          ),

          const SizedBox(height: 25),

          /// --- SLIDER ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: _maxSliderValue,
                  onChanged: (value) {
                    setState(() => _currentSliderValue = value);
                  },
                  onChangeEnd: (value) {
                    widget.player.seek(
                      Duration(seconds: value.toInt()),
                    ); // 👈 ACTUAL SEEK
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(_currentSliderValue.toInt()),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      widget.duration,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          /// CONTROLS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                iconSize: 42,
                onPressed: () {},
              ),
              const SizedBox(width: 25),
              IconButton(
                icon: const Icon(
                  Icons.pause_circle_filled,
                  color: Colors.white,
                ),
                iconSize: 55,
                onPressed: () => widget.player.pause(),
              ),
              const SizedBox(width: 25),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                iconSize: 42,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
